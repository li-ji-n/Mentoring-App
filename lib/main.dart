import 'package:flutter/material.dart';
import 'package:login/providers/hodLoginService.dart';
import 'package:login/providers/hodService.dart';
import 'package:login/providers/login.dart';

import 'package:provider/provider.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';
import './screens/hod/hodLogin.dart';
import './screens/student/studentLogin.dart';
import './screens/mentor/mentorLogin.dart';
import 'homePage.dart';

Future<void> main() async {
  runApp(MyApp(
      // debugShowCheckedModeBanner: false,
      // title: 'Navigation Basics',
      // home: HomePage(),

      ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CommonService()),
        ChangeNotifierProvider.value(value: LoginService()),
        ChangeNotifierProvider.value(value: StudentService()),
      ],
      child: MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Mentoring App',
        home: HomePage(),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.

          // When navigating to the "/second" route, build the SecondScreen widget.
          '/hodLoginPage': (context) => HodLoginPage(),
          '/studentLoginPage': (context) => StudentLoginPage(),
          '/mentorLoginPage': (context) => StudentLoginPage(),
        },
      ),
    );
  }
}
