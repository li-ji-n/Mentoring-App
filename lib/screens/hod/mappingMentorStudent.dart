import 'package:flutter/material.dart';
import 'package:login/dummyData.dart/dummyDt.dart';
import 'package:login/providers/login.dart';
import 'package:login/screens//hod/hodLogin.dart';
import 'package:login/screens//hod/hodMainPage.dart';
import 'package:login/screens//hod/mentorStudentListing.dart';
import 'package:login/model/mappingModel.dart';
import 'package:login/providers/hodService.dart';
import 'package:login/screens/mentor/studentListView.dart';

import 'package:provider/provider.dart';

class MapStudentMentor extends StatefulWidget {
  final fromStudent;
  MapStudentMentor({this.fromStudent});
  @override
  _MapStudentMentorState createState() => _MapStudentMentorState();
}

class _MapStudentMentorState extends State<MapStudentMentor> {
  List<String> batchList = [];
  List<String> classSectionList = [];
  List<dynamic> mentorListGroup = [];
  int groupId = 0;
  List<dynamic> studentList = [];
  retrieveGroupId(selectedBatch, selectedClass) {
    for (var i = 0; i < groups.length; i++) {
      if (groups[i]['class'] == selectedClass &&
          groups[i]['batch'] == selectedBatch) {
        groupId = groups[i]['id'];
        if (groups[i]['mentors'] != null) {
          groups[i]['mentors'].forEach((item) {
            mentorListGroup.add(item);
          });
        }

        break;
      }
    }

    // return groupId;
  }

  filterStudentList() async {
    // print(widget.groupId);
    // print(widget.mentors);
    List<dynamic> studentL = [];
    List<dynamic> mentorL = [];
    if (selectedBatch == 'S7/S8' && selectedClass == 'CSE A') {
      studentL = await Provider.of<StudentService>(context, listen: false)
          .getStudentList();
      mentorL = await Provider.of<StudentService>(context, listen: false)
          .getMentorList(selectedClass, selectedBatch);
    }
    if (studentList.length == 0) {
      studentL.forEach((item) {
        if (studentL.isNotEmpty) {
          if (studentList.isNotEmpty) {
            if (!studentList.contains(item)) {
              studentList.add(item);
            }
          } else {
            studentList.add(item);
          }
        }
      });
      //  retrieveGroupId(selectedBatch, selectedClass);
    }

    if (mentorListGroup.length == 0) {
      mentorL.forEach((item) {
        if (mentorL.isNotEmpty) {
          if (mentorListGroup.isNotEmpty) {
            if (!mentorListGroup.contains(item)) {
              mentorListGroup.add(item);
            }
          } else {
            mentorListGroup.add(item);
          }
        }
      });
      //  retrieveGroupId(selectedBatch, selectedClass);
    }
    if (widget.fromStudent == 'false') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MentorStudentListing(
              studentList: studentList,
              mentors: mentorListGroup,
              selectedClass: selectedClass,
              selectedBatch: selectedBatch),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentListView(studentList: studentList)),
      );
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // groupId = 0;
    // selectedBatch = null;
    // selectedClass = null;

    classSection.forEach((item) {
      if (classSectionList.isNotEmpty) {
        if (!classSectionList.contains(item['name'])) {
          classSectionList.add(item['name']);
        }
      } else {
        classSectionList.add(item['name']);
      }
    });

    batch.forEach((item) {
      if (batchList.isNotEmpty) {
        if (!batchList.contains(item['name'])) {
          batchList.add(item['name']);
        }
      } else {
        batchList.add(item['name']);
      }
    });
  }

  String selectedBatch;
  String selectedClass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink[900],
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.keyboard_arrow_left)),
        actions: <Widget>[
          Row(
            children: <Widget>[],
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
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: Center(
          child: Column(
            children: <Widget>[
              Center(
                  child: Text(
                'Select Batch and Class',
                style: TextStyle(fontSize: 27),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Select Batch',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      new DropdownButton<String>(
                        value: selectedBatch,
                        hint: Text(
                          'Choose Batch',
                          style: TextStyle(fontSize: 12),
                        ),
                        items: batchList.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedBatch = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Text('\n'),
                  Column(
                    children: <Widget>[
                      Text('Select Class',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      new DropdownButton<String>(
                        value: selectedClass,
                        hint: Text(
                          'Choose Class',
                          style: TextStyle(fontSize: 12),
                        ),
                        items: classSectionList.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedClass = value;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                  child: RaisedButton(
                color: selectedClass != null && selectedBatch != null
                    ? Colors.pink[900]
                    : Colors.grey,
                onPressed: selectedClass != null && selectedBatch != null
                    ? () {
                        // retrieveGroupId(selectedBatch, selectedClass);
                        filterStudentList();
                      }
                    : () {},
                child: Text(
                  'Show Result',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
