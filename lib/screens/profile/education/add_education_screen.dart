import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/models/education/education.dart';
import 'package:taskproject/models/education/userEducation/user_education.dart';
import 'package:taskproject/router.dart';
import 'package:taskproject/service/http_client.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/util/broadcast_stream.dart';
import 'package:taskproject/util/date_extension.dart';
import 'package:taskproject/util/status_codes.dart';
import 'package:taskproject/widgets/buttons/main_button_with_icon.dart';
import 'package:taskproject/widgets/date/date_holder.dart';
import 'package:taskproject/widgets/forms/app_form.dart';
import 'package:taskproject/widgets/forms/search_form.dart';
import 'package:taskproject/widgets/toasts/toasts.dart';

class AddEducationScreen extends StatefulWidget {
  final UserEducation userEducation;

  const AddEducationScreen({Key key, this.userEducation}) : super(key: key);

  @override
  _AddEducationScreenState createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  var _descriptionController = new TextEditingController();
  List<Education> _educationList = new List();
  HttpService _httpService = HttpClient.getInstance();
  Education _selectedEducation;
  UserEducation _myEducation = new UserEducation();
  @override
  void initState() {
    if (widget.userEducation != null) {
      _myEducation = widget.userEducation;
      _selectedEducation = _myEducation.education;
      _descriptionController.text = _myEducation.description;
    }
    super.initState();
  }

  void moveToSearchPage() async {
    final _newEducation =
        (await Navigator.pushNamed(context, searchEducationRoute));
    if (_newEducation != null) {
      _selectedEducation = _newEducation;
      _myEducation.education = _selectedEducation;
    }
    setState(() {});
  }

  void saveEducation() async {
    _myEducation.description = _descriptionController.text;
    Response response;
    if (_myEducation.educationId == null) {
      response = await _httpService.addUserEducation(_myEducation);
    } else {
      response = await _httpService.updateUserEducation(_myEducation);
    }
    if (response.statusCode == StatusCodes.ok) {
      Toasts.showSuccessToasts('Success.');
    } else {
      Toasts.showErrorToast('Error while updating education.');
    }
    refreshProfileSection();
    Navigator.of(context).pop();
  }

  refreshProfileSection() {
    sendBroadcastMessage(refreshProfileEducation);
  }

  void deleteEducation() async {
    Response response =
        await _httpService.deleteUserEducation(_myEducation.userEducationId);
    if (response.statusCode == StatusCodes.ok) {
      refreshProfileSection();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            FlatButton(
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  saveEducation();
                })
          ],
          title: Text('Education'),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      children: <Widget>[
        SearchForm(
          imgUrl: _selectedEducation == null
              ? null
              : HttpService.getEducationIconPath(
                  _selectedEducation.educationId),
          hint: _selectedEducation == null
              ? 'Search'
              : _selectedEducation.educationName,
          onPress: () {
            moveToSearchPage();
          },
        ),
        AppForm(
          label: 'Description',
          controller: _descriptionController,
          obscureText: false,
        ),
        startDateWidget(),
        endDateWidget(),
        if (_myEducation.userEducationId != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: MainButtonWithIcon(
              icon: Icons.delete,
              color: Color(0xff455A64),
              title: 'Delete Education',
              onPressButton: () {
                deleteEducation();
              },
            ),
          )
      ],
    );
  }

  Widget startDateWidget() {
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: DateHolder(
          dateFormat: ddMMyyyyFormat,
          hint: 'Start Date',
          initialDate: _myEducation.startDate,
          onDateSelect: (value) {
            setState(() {
              _myEducation.startDate = value;
            });
          },
        ));
  }

  Widget endDateWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: DateHolder(
        dateFormat: ddMMyyyyFormat,
        hint: 'End Date',
        initialDate: _myEducation.endDate,
        onDateSelect: (value) {
          setState(() {
            _myEducation.endDate = value;
          });
        },
      ),
    );
  }
}
