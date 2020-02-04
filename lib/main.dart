import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskproject/router.dart';
import 'package:taskproject/screens/login_screen.dart';
import 'package:taskproject/screens/profile/edit_profile_screen.dart';
import 'package:taskproject/theme/my_theme.dart';
import 'package:taskproject/screens/profile/profile_screen.dart';
import 'package:taskproject/util/broadcast_stream.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setLightStatusBar();
    registerStream();
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
      initialRoute: homeRoute,
      title: 'Flutter Demo',
      theme: MyTheme.getTheme(),
      //home: LoginScreen(),
    );
  }

  setLightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
  }

  registerStream() {
    new BroadcastStream();
  }
}
