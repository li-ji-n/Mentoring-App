import 'package:flutter/material.dart';
import 'package:login/dummyData.dart/dummyDt.dart';
import 'package:login/providers/login.dart';
import 'package:login/screens/hod/hodLogin.dart';
import 'package:login/screens/hod/hodMainPage.dart';
import 'package:login/screens/hod/mappingMentorStudent.dart';
import 'package:login/screens/hod/viewStudentList.dart';
import 'package:login/providers/hodService.dart';

import 'package:login/studentsList.dart';
import 'package:provider/provider.dart';
import 'package:quiver/iterables.dart';

class MentorStudentListing extends StatefulWidget {
  // int groupId;
  List<dynamic> mentors;
  var selectedClass;
  var selectedBatch;
  List<dynamic> studentList;
  MentorStudentListing(
      {Key key,
      this.studentList,
      this.mentors,
      this.selectedClass,
      this.selectedBatch})
      : super(key: key);

  @override
  _MentorStudentListingState createState() => _MentorStudentListingState();
}

List<dynamic> mentorList = [];
// List<dynamic> studentList = [];
String selectedMentor;
bool _value = false;

class _MentorStudentListingState extends State<MentorStudentListing> {
  List<dynamic> newList = [];

  bool disableFlag = true;
  List<dynamic> filteredStudentList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedMentor = null;
    // studentList.clear();
    mentorList.clear();
    widget.mentors.forEach((item) {
      if (widget.mentors.isNotEmpty) {
        if (!mentorList.contains(item)) {
          mentorList.add(item);
        }
      } else {
        mentorList.add(item);
      }
    });
    // checkIfStudentAlreadyAssigned();

    // filterStudentList();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    selectedMentor = null;
    // studentList.clear();
    mentorList.clear();
    widget.mentors.forEach((item) {
      if (widget.mentors.isNotEmpty) {
        if (!mentorList.contains(item)) {
          mentorList.add(item);
        }
      } else {
        mentorList.add(item);
      }
    });

    // filterStudentList();
    // divideStudentsUnderMentor();
  }

  bool checkIfStudentAlreadyAssigned() {
    widget.studentList.forEach((item) {
      if (item['mflag'] == '0') {
        disableFlag = true;
      } else {
        disableFlag = false;
      }
    });
    print('sssdsdssdsdsdsdsds');
    print(disableFlag);
    print('sssdsdssdsdsdsdsds');
    return disableFlag;
  }

  filterStudentUnderMentor(mentorId) {
    filteredStudentList.clear();
    widget.studentList.forEach((item) {
      if (item['mflag'] == mentorId) {
        filteredStudentList.add(item);
      }
    });
    print(filteredStudentList);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewStudentList(
          studentList: filteredStudentList,
        ),
      ),
    );
  }

  divideStudentsUnderMentor() async {
    var pairs = partition(widget.studentList, 20);
    // print(pairs);
    var mentorItemVal = 0;
    pairs.forEach((item) {
      if (mentorItemVal <= 2) {
        item.forEach((subItem) {
          subItem.addAll({'mentorId': widget.mentors[mentorItemVal]['id']});
        });
        mentorItemVal++;
      }
    });

    List<dynamic> mappedList = [];
    var list1;
    var list2;
    var list3;
    var list4;
    var newL = [];
    pairs.forEach((item) {
      mappedList.add(item);
    });
    var m1 = widget.mentors[0]['id'];
    var m2 = widget.mentors[1]['id'];
    var m3 = widget.mentors[2]['id'];

    list1 = mappedList[0];
    list2 = mappedList[1];
    list3 = mappedList[2];

    list4 = mappedList[3];
    newL = [list1, list2, list3, list4].expand((x) => x).toList();

    newL.forEach((item) {
      if (!item.containsKey('mentorId')) {
        item.addAll({'mentorId': m3});
      }
    });

    var result = await Provider.of<StudentService>(context, listen: false)
        .assignStudentMentor(m1, m2, m3, newL)
        .then((response) {
      if (response != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => MainPageHod()),
          ModalRoute.withName('/'),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink[900],
        leading: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MapStudentMentor()),
                ModalRoute.withName('/'),
              );
            },
            child: Icon(Icons.keyboard_arrow_left)),
        actions: <Widget>[
          Row(
            children: <Widget>[
           
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
      body: widget.studentList.length > 0
          ? Container(
              height: height * 0.90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Mentors for\n',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      TextSpan(
                          text:
                              '${widget.selectedBatch} ,\t ${widget.selectedClass}',
                          style: TextStyle(color: Colors.black, fontSize: 23))
                    ]),
                  ),
                  Center(
                    child: Container(
                      width: width * 0.9,
                      height: height * 0.5,
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                        itemCount: mentorList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = mentorList[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                                onPressed: () {
                                  filterStudentUnderMentor(item['id']);
                                },
                                color: Colors.pink[900],
                                child: Text(
                                  item['name'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )),
                          );
                        },
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ),
                  checkIfStudentAlreadyAssigned() == true
                      ? RaisedButton(
                          color: Colors.pink[900],
                          onPressed: () {
                            divideStudentsUnderMentor();
                          },
                          child: Text(
                            'Assign students',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ))
                      : Text('')
                ],
              ),
            )
          : Center(
              child: Container(child: Text('Student list is empty!')),
            ),
    );
  }
}
