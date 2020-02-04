import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/models/education/education.dart';
import 'package:taskproject/models/education/education_response.dart';
import 'package:taskproject/service/http_client.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/widgets/forms/app_form.dart';
import 'package:taskproject/widgets/items/item_search.dart';
import 'package:taskproject/widgets/progress_widget.dart';

class SearchEducationScreen extends StatefulWidget {
  @override
  _SearchEducationScreenState createState() => _SearchEducationScreenState();
}

class _SearchEducationScreenState extends State<SearchEducationScreen> {
  var _inputController = new TextEditingController();
  HttpService _httpService = HttpClient.getInstance();
  List<Education> _educationList = new List();
  bool _isSearching = false;
  @override
  void initState() {
    _inputController.addListener(sendKeyWord);
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  sendKeyWord() {
    String keyWord = _inputController.text;
    if (keyWord.isEmpty) {
      _isSearching = false;
      setState(() {
        _educationList.clear();
      });
      return;
    }
    filter(keyWord);
  }

  filter(String keyWord) async {
    setState(() {
      _isSearching = true;
    });
    Response response = await _httpService.filterEducations(keyWord);
    EducationResponse educationResponse =
        EducationResponse.fromJsonArray(response.data);
    _educationList = educationResponse.educationList;
    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Search'),
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
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      children: <Widget>[
        AppForm(
          label: 'Keyword',
          obscureText: false,
          controller: _inputController,
        ),
        _isSearching
            ? Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ProgressWidget(),
              )
            : list()
      ],
    );
  }

  Widget list() {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: _educationList.length,
      itemBuilder: (context, pos) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pop(_educationList[pos]);
          },
          child: ItemSearch(
            imgUrl: HttpService.getEducationIconPath(
                _educationList[pos].educationId),
            text: _educationList[pos].educationName,
          ),
        );
      },
    );
  }
}
