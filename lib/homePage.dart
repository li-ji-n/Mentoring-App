import 'package:flutter/material.dart';
import 'package:login/providers/hodLoginService.dart';
import 'package:provider/provider.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';
import './screens/hod/hodLogin.dart';
import './screens/student/studentLogin.dart';
import './screens/mentor/mentorLogin.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Center(
              child: Text(
            "MENTORING APP",
            textAlign: TextAlign.center,
          )),
          backgroundColor: Colors.pink[900],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 50),
              SizedBox(
                height: 200.0,
                width: 200.0,
                child: Image(image: AssetImage("assets/mentor.png")),
              ),
              SizedBox(
                width: 200,
                height: 50, // hard coding child width
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.pink[900])),
                  color: Colors.pink[900],
                  textColor: Colors.white,
                  child: Text(
                    'HOD',
                    style: new TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HodLoginPage()),
                    );
                  },
                ),
              ),

              SizedBox(
                height: 20,
                width: 500,
              ),
              SizedBox(
                width: 200,
                height: 50, // hard coding child width
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.pink[900])),
                  color: Colors.pink[900],
                  textColor: Colors.white,
                  child: Text(
                    'MENTOR',
                    style: new TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MentorLoginPage()),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200, // hard coding child width
                height: 50,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.pink[900])),
                  color: Colors.pink[900],
                  textColor: Colors.white,
                  child: Text(
                    'STUDENT',
                    style: new TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentLoginPage()),
                    );
                  },
                ),
              ),
              SizedBox(height: 5)
            ],
          ),
        ),
      ),
    );
  }
}
