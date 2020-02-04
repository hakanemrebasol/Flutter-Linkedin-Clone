import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/models/publication/publication.dart';
import 'package:taskproject/service/http_client.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/util/broadcast_stream.dart';
import 'package:taskproject/util/custom_colors.dart';
import 'package:taskproject/util/date_extension.dart';
import 'package:taskproject/util/status_codes.dart';
import 'package:taskproject/widgets/buttons/main_button.dart';
import 'package:taskproject/widgets/buttons/main_button_with_icon.dart';
import 'package:taskproject/widgets/date/date_holder.dart';
import 'package:taskproject/widgets/forms/app_form.dart';
import 'package:taskproject/widgets/date/my_date_picker.dart';
import 'package:taskproject/widgets/toasts/toasts.dart';

class AddPublicationScreen extends StatefulWidget {
  final Publication publication;

  const AddPublicationScreen({Key key, this.publication}) : super(key: key);

  @override
  _AddPublicationScreenState createState() => _AddPublicationScreenState();
}

class _AddPublicationScreenState extends State<AddPublicationScreen> {
  HttpService _httpService = HttpClient.getInstance();
  var _publisherNameController = new TextEditingController();
  var _urlController = new TextEditingController();
  var _descriptionController = new TextEditingController();
  var _publication = new Publication();
  @override
  void initState() {
    if (widget.publication != null) {
      _publication = widget.publication;
      _publisherNameController.text = _publication.publisherName;
      _urlController.text = _publication.url;
      _descriptionController.text = _publication.description;
    }
    super.initState();
  }

  savePublication() async {
    _publication.description = _descriptionController.text;
    _publication.publisherName = _publisherNameController.text;
    _publication.url = _urlController.text;
    _publication.description = _descriptionController.text;
    Response response;
    if (_publication.publicationId == null) {
      response = await _httpService.addPublication(_publication);
    } else {
      response = await _httpService.updatePublication(_publication);
    }
    if (response.statusCode == StatusCodes.ok) {
      _refreshProfilePublications();
      Toasts.showSuccessToasts('Success.');
      Navigator.of(context).pop();
    }
  }

  void deletePublication() async {
    Response response =
        await _httpService.deletePublication(_publication.publicationId);
    if (response.statusCode == StatusCodes.ok) {
      _refreshProfilePublications();
      Navigator.of(context).pop();
    }
  }

  _refreshProfilePublications() {
    sendBroadcastMessage(refreshAccomplishments);
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
                  savePublication();
                })
          ],
          title: Text('Publication'),
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
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      children: <Widget>[
        AppForm(
          label: 'Publisher Name',
          obscureText: false,
          controller: _publisherNameController,
        ),
        pickDateWidget(),
        AppForm(
          label: 'Url',
          obscureText: false,
          controller: _urlController,
        ),
        AppForm(
          label: 'Description',
          obscureText: false,
          controller: _descriptionController,
        ),
        if (_publication.publicationId != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: MainButtonWithIcon(
              icon: Icons.delete,
              color: Color(0xff455A64),
              title: 'Delete Publication',
              onPressButton: () {
                deletePublication();
              },
            ),
          )
      ],
    );
  }

  Widget pickDateWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: DateHolder(
        hint: 'Publication Date',
        dateFormat: MMyyyyFormat,
        initialDate: _publication.publishDate,
        onDateSelect: (value) {
          setState(() {
            _publication.publishDate = value;
          });
        },
      ),
    );
  }
}
