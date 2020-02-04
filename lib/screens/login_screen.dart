import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/helper/preferences_manager.dart';
import 'package:taskproject/models/authentication/authentication_response.dart';
import 'package:taskproject/models/authentication/login_model.dart';
import 'package:taskproject/router.dart';
import 'package:taskproject/widgets/forms/app_form.dart';
import 'package:taskproject/widgets/buttons/main_button.dart';
import 'package:taskproject/widgets/progress_widget.dart';
import 'package:taskproject/widgets/toasts/toasts.dart';
import 'package:taskproject/service/http_client.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/util/status_codes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordControler = new TextEditingController();
  HttpService _httpService = HttpClient.getInstance();
  PreferencesManager _pm = new PreferencesManager();
  bool isSending = false;
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordControler.dispose();
    super.dispose();
  }

  @override
  void initState() {
    resetLogin();
    super.initState();
  }

  resetLogin() async{
    await _pm.resetLoginDetails();
  }

  @override
  Widget build(BuildContext context) {
    _usernameController.text = "hakanemrebasol@gmail.com";
    _passwordControler.text = "123456";
    return Scaffold(
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 64, 32, 32),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 32),
                child: Image.asset(
                  'assets/images/ic_linkedin.png',
                  width: 65,
                ),
              ),
              AppForm(
                controller: _usernameController,
                label: 'Username',
                obscureText: false,
              ),
              AppForm(
                controller: _passwordControler,
                label: 'Password',
                obscureText: true,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: isSending ? ProgressWidget() : loginButton())
            ],
          ),
        ),
      ),
    );
  }

  loginButton() {
    return SizedBox(
      width: double.infinity,
      child: MainButton(
        title: 'Login',
        onPressButton: () {
          validateFields();
        },
      ),
    );
  }

  containerDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xff087788),
          Color(0xff0074B1),
        ],
      ),
    );
  }

  login(LoginModel loginModel) async {
    setState(() {
      isSending = true;
    });
    Response response =
        await _httpService.getTokenWithPassword(loginModel, true);

     if (response!=null && response.statusCode == StatusCodes.ok) {
      Toasts.showSuccessToasts('Success!');
      AuthenticationResponse authResp =
          AuthenticationResponse.fromJson(response.data);
      _pm.saveLoginDetails(authResp, true);
      Navigator.pushReplacementNamed(context, profileRoute);
      return;
    }

    Toasts.showErrorToast('Wrong username or password.');
    setState(() {
      isSending = false;
    });
  }

  validateFields() {
    if (_usernameController.text.isEmpty) {
      Toasts.showWarningToast('Fill username.');
      return;
    }

    if (_passwordControler.text.isEmpty) {
      Toasts.showWarningToast('Fill password.');
      return;
    }
    LoginModel loginModel = new LoginModel(
        username: _usernameController.text, password: _passwordControler.text);
    login(loginModel);
  }
}
