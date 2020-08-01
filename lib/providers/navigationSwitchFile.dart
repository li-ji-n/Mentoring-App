import 'package:flutter/material.dart';
import 'package:login/screens/hod/hodMainPage.dart';
import 'package:login/screens/mentor/mentorMainPage.dart';
import 'package:login/providers/hodService.dart';
import 'package:login/providers/login.dart';
import 'package:login/screens/student/studentMainPage.dart';
import 'package:provider/provider.dart';

///
///Method to decide to which page the user is to be navigated on login success
///
navigateFunc(val, context) {
  switch (val) {
    case '0': //HOD login
      Provider.of<LoginService>(context).userType = val;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPageHod()),
      );
      break;
    case '1': //mentor login
      Provider.of<LoginService>(context).userType = val;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPageMentor()),
      );
      break;
    case '2': //student login
      Provider.of<LoginService>(context).userType = val;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPageStudent()),
      );

      break;
    default:
  }
}
