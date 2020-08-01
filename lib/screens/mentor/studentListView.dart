import 'package:flutter/material.dart';
import 'package:login/dummyData.dart/dummyDt.dart';
import 'package:login/providers/hodService.dart';
import 'package:login/providers/login.dart';
import 'package:login/screens/hod/hodLogin.dart';
import 'package:login/screens/hod/mappingMentorStudent.dart';
import 'package:login/screens/hod/viewStudentList.dart';
import 'package:login/screens/mentor/mentorLogin.dart';
import 'package:login/screens/mentor/studentDetails.dart';
import 'package:login/screens/studentReports/studentReportFile.dart';
import 'package:login/studentsList.dart';
import 'package:provider/provider.dart';

class StudentListView extends StatefulWidget {
  final List<dynamic> studentList;
  StudentListView({this.studentList});
  @override
  _State createState() => _State();
}

class _State extends State<StudentListView> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // calcStudentList();
  }

  List<dynamic> filteredStudentList = [];
  String selectedMonth;
  // calcStudentList() {
  //   if (widget.studentList != null) {
  //     for (var i = 0; i < widget.studentList.length; i++) {

  //         if (filteredStudentList.isEmpty) {
  //           filteredStudentList.add(widget.studentList[i]);
  //         } else {
  //           if (!filteredStudentList.contains(widget.studentList[i])) {
  //             filteredStudentList.add(widget.studentList[i]);
  //           }

  //       }
  //     }
  //   }
  //   return filteredStudentList;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
             Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MapStudentMentor()),
                ModalRoute.withName('/'),
              );
            },
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            )),
        title: const Text('Student List'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink[900],
        actions: <Widget>[
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
                            builder: (BuildContext context) =>
                                MentorLoginPage()),
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
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          // color: Colors.yellow,
          child: widget.studentList.length > 0
              ? ListView.builder(
                  itemCount: widget.studentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shadowColor: Colors.pink[900],
                      color: Colors.grey[200],
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: InkWell(
                        onTap: () {
                          Provider.of<StudentService>(context)
                              .getRatingStudent(widget.studentList[index]['id'],
                                  selectedMonth)
                              .then((resp) {
                            print(resp.reversed);
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentReport(
                                      graphList: resp,
                                      student: widget.studentList[index])),
                            );
                          });
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => StudentDetails(student: widget.studentList[index])),
                          // );
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.pink[900],
                            child: CircleAvatar(
                              radius: 25,
                              foregroundColor: Colors.pink[900],
                              backgroundImage:AssetImage("assets/user.png")
                                
                            ),
                          ),
                          title: Text(
                            widget.studentList[index]['name'],
                            style: TextStyle(
                                color: Colors.pink[900],
                                fontWeight: FontWeight.w700),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.pink[900],
                          ),
                        ),
                      ),
                    );
                  })
              : Center(
                  child: Container(
                      child: Text(
                  'No students assigned !',
                  style: TextStyle(fontSize: 20),
                ))),
        ),
      ),
    );
  }
}
