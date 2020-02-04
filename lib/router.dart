import 'package:flutter/material.dart';
import 'package:taskproject/screens/login_screen.dart';
import 'package:taskproject/screens/profile/accomplishments/add_publication_screen.dart';
import 'package:taskproject/screens/profile/edit_about_screen.dart';
import 'package:taskproject/screens/profile/edit_profile_screen.dart';
import 'package:taskproject/screens/profile/education/add_education_screen.dart';
import 'package:taskproject/screens/profile/enlarge_profile_picture.dart';
import 'package:taskproject/screens/profile/experience/add_experience_screen.dart';
import 'package:taskproject/screens/profile/profile_screen.dart';
import 'package:taskproject/screens/profile/skill/add_skill_screen.dart';
import 'package:taskproject/screens/search_education_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case editProfileRoute:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      case editAboutRoute:
        return MaterialPageRoute(builder: (_) => EditAboutScreen(aboutText: settings.arguments,));
      case addExperienceRoute:
        return MaterialPageRoute(builder: (_) => AddExperienceScreen(experience: settings.arguments,));
      case addEducationRoute:
        return MaterialPageRoute(builder: (_) => AddEducationScreen(userEducation: settings.arguments,));
      case searchEducationRoute:
        return MaterialPageRoute(builder: (_) => SearchEducationScreen());
      case addSkillRoute:
        return MaterialPageRoute(builder: (_) => AddSkilScreen());
      case enlargePProute:
        return MaterialPageRoute(builder: (_) => EnlargeProfilePicture(userId: settings.arguments,));
      case addPublicationRoute:
        return MaterialPageRoute(builder: (_) => AddPublicationScreen(publication: settings.arguments,));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Unable to find route.'),
            ),
          ),
        );
    }
  }
}

const String homeRoute = '/';
const String profileRoute = '/profile';
const String editProfileRoute = '/editProfile';
const String editAboutRoute = '/editAbout';
const String addExperienceRoute = '/addExperience';
const String addEducationRoute = '/addEducation';
const String searchEducationRoute = '/searchEducation';
const String addSkillRoute = '/addSkill';
const String addPublicationRoute = '/addPublication';
const String enlargePProute = '/enlargePP';

