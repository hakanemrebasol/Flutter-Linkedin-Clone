import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/models/company/company.dart';
import 'package:taskproject/models/company/company_response.dart';
import 'package:taskproject/models/experience/experience.dart';
import 'package:taskproject/service/http_client.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/util/broadcast_stream.dart';
import 'package:taskproject/util/custom_colors.dart';
import 'package:taskproject/util/date_extension.dart';
import 'package:taskproject/util/status_codes.dart';
import 'package:taskproject/widgets/buttons/main_button_with_icon.dart';
import 'package:taskproject/widgets/date/date_holder.dart';
import 'package:taskproject/widgets/forms/app_form.dart';
import 'package:taskproject/widgets/toasts/toasts.dart';

class AddExperienceScreen extends StatefulWidget {
  final Experience experience;

  const AddExperienceScreen({Key key, this.experience}) : super(key: key);
  @override
  _AddExperienceScreenState createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  var _titleController = new TextEditingController();
  var _locationController = new TextEditingController();
  var _descriptionController = new TextEditingController();
  Experience _experience = new Experience();
  List<Company> _companyList = new List();
  Company _selectedCompany;
  HttpService _httpService = HttpClient.getInstance();

  @override
  void initState() {
    if (widget.experience != null) {
      _experience = widget.experience;
      _locationController.text = _experience.location;
      _descriptionController.text = _experience.description;
      _titleController.text = _experience.title;
      _selectedCompany = _experience.company;
    }
    getCompanyList();
    super.initState();
  }

  _setSelectedCompany() {
    _selectedCompany = _companyList.firstWhere(
        (company) => company.companyId == _selectedCompany.companyId,
        orElse: () => null);
    setState(() {});
  }

  getCompanyList() async {
    Response response = await _httpService.getCompanies();
    CompanyResponse companyResponse =
        CompanyResponse.fromJsonArray(response.data);
    setState(() {
      _companyList = companyResponse.companyList;
    });
    if (_selectedCompany != null) {
      _setSelectedCompany();
    }
  }

  _refreshProfileExperience() {
    sendBroadcastMessage(refreshProfileExperience);
  }

  saveExperience() async {
    _experience.description = _descriptionController.text;
    _experience.title = _titleController.text;
    _experience.location = _locationController.text;
    Response response;
    if (_experience.experienceId == null) {
      response = await _httpService.addUserExperience(_experience);
    } else {
      response = await _httpService.updateUserExperience(_experience);
    }
    if (response.statusCode == StatusCodes.ok) {
      _refreshProfileExperience();
      Toasts.showSuccessToasts('Success');
      Navigator.of(context).pop();
    }
  }

  void deleteExperience() async {
    Response response =
        await _httpService.deleteUserExperience(widget.experience.experienceId);
    if (response.statusCode == StatusCodes.ok) {
      _refreshProfileExperience();
      Toasts.showSuccessToasts('Success');
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
                  saveExperience();
                })
          ],
          title: Text('Experience'),
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
        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
        child: body(),
      )),
    );
  }

  Widget body() {
    return Column(
      children: <Widget>[
        AppForm(
          label: 'Title',
          controller: _titleController,
          obscureText: false,
        ),
        AppForm(
          label: 'Location',
          controller: _locationController,
          obscureText: false,
        ),
        AppForm(
          label: 'Description',
          controller: _descriptionController,
          obscureText: false,
        ),
        startDateWidget(),
        endDateWidget(),
        companyDropDown(),
        if (widget.experience != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: MainButtonWithIcon(
              icon: Icons.delete,
              color: Color(0xff455A64),
              title: 'Delete Experience',
              onPressButton: () {
                deleteExperience();
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
        hint: 'Start Date',
        dateFormat: MMyyyyFormat,
        initialDate: _experience.startDate,
        onDateSelect: (value) {
          setState(() {
            //print(value.toIso8601String());
            _experience.startDate = value;
          });
        },
      ),
    );
  }

  Widget endDateWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: DateHolder(
        hint: 'End Date',
        dateFormat: MMyyyyFormat,
        initialDate: _experience.endDate,
        onDateSelect: (value) {
          setState(() {
            _experience.endDate = value;
          });
        },
      ),
    );
  }

  Widget companyDropDown() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Company',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .merge(TextStyle(color: CustomColors.colorPrimary)),
            ),
            DropdownButton<Company>(
                items: _companyList.map((Company val) {
                  return new DropdownMenuItem<Company>(
                    value: val,
                    child: new Text(val.companyName),
                  );
                }).toList(),
                hint: Text("Please choose a company"),
                value: _selectedCompany,
                onChanged: (newVal) {
                  this.setState(() {
                    _selectedCompany = newVal;
                    _experience.company = newVal;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
