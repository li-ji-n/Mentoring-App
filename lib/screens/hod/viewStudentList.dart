import 'package:flutter/material.dart';
import 'package:login/providers/login.dart';
import 'package:login/screens/hod/hodLogin.dart';
import 'package:login/screens/hod/hodMainPage.dart';
import 'package:login/screens/hod/mappingMentorStudent.dart';
import 'package:login/screens/hod/mentorStudentListing.dart';
import 'package:provider/provider.dart';

class ViewStudentList extends StatefulWidget {
  List<dynamic> studentList;
  ViewStudentList({
    Key key,
    this.studentList,
  }) : super(key: key);
  @override
  _ViewStudentListState createState() => _ViewStudentListState();
}

class _ViewStudentListState extends State<ViewStudentList> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign'),
        automaticallyImplyLeading: false,
        backgroundColor:Colors.pink[900],
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (context) => MentorStudentListing()),
              //   // ModalRoute.withName('/'),
              // );
            },
            child: Icon(Icons.keyboard_arrow_left)),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.calendar_today),
                tooltip: 'Master Calender',
                onPressed: () {},
              ),
              IconButton(
                  onPressed: () {},
                  icon: Stack(
                    children: <Widget>[
                      Icon(Icons.notifications, color: Colors.white),
                      Positioned(
                          left: 15.0,
                          child: Icon(
                            Icons.brightness_1,
                            color: Colors.pink[900],
                            size: 9.0,
                          ))
                    ],
                  )),
            ],
          ),
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text(Provider.of<LoginService>(context).userName),
              ),
              PopupMenuItem(
                  value: 2,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MainPageHod()),
                        ModalRoute.withName('/'),
                      );
                    },
                    child: Text(
                      "Home",
                    ),
                  )),
              PopupMenuItem(
                  value: 2,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MapStudentMentor()),
                        ModalRoute.withName('/'),
                      );
                    },
                    child: Text(
                      "Assign Mentor",
                    ),
                  )),
              PopupMenuItem(
                  value: 2,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HodLoginPage()),
                        ModalRoute.withName('/'),
                      );
                    },
                    child: Text(
                      "Logout",
                    ),
                  )),
            ],
            icon: Icon(
              Icons.account_circle,
              size: 30,
              color: Colors.white,
            ),
            tooltip: 'Account',
          ),
        ],
      ),
      body: Container(
        width: width,
        height: height * 0.9,
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: widget.studentList.length,
          itemBuilder: (BuildContext context, int index) {
            final item = widget.studentList[index];

            return Container(
              width: width * 0.8,
              height: height * 0.08,
            
              child: Card(
                  child: Padding(
                    padding: EdgeInsets.only(left:15,top:18),
                    child: Text(
                item['name'],
                style: TextStyle(color: Colors.black, fontSize: 16),
                textAlign: TextAlign.left,
              ),
                  )),
            );
          },
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
