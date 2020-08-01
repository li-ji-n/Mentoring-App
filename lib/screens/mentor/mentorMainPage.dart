import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/meetingSchedule.dart/calenderEvents.dart';
import 'package:login/screens/mentor/createTask.dart';
import 'package:login/screens/mentor/mentorLogin.dart';
import 'package:login/screens/mentor/studentListView.dart';
import 'package:login/screens/mentor/studentRating.dart';
import 'package:login/providers/hodService.dart';
import 'package:login/providers/login.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class MainPageMentor extends StatefulWidget {
  MainPageMentor({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MainPageMentor> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<dynamic> filteredStudentList = [];
  List<dynamic> studentL = [];

  fetchStudentListAll() async {
    var mentorId = Provider.of<LoginService>(context).mentorId;
    filteredStudentList.clear();
    await Provider.of<StudentService>(context, listen: false)
        .getStudentList()
        .then((response) {
      if (response != null) {
        studentL = response;
        studentL.forEach((item) {
          if (item['mflag'] == mentorId) {
            filteredStudentList.add(item);
          }
        });
      }

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                StudentListView(studentList: filteredStudentList)),
      );
    });
  }

  fetchStudentList() async {
    var mentorId = Provider.of<LoginService>(context).mentorId;
    filteredStudentList.clear();
    await Provider.of<StudentService>(context, listen: false)
        .getStudentList()
        .then((response) {
      if (response != null) {
        studentL = response;
        studentL.forEach((item) {
          if (item['mflag'] == mentorId) {
            filteredStudentList.add(item);
          }
        });
      }
    });
  }

  showAlertDialog(BuildContext context, height, width, notificationList) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            color: Colors.transparent,
            // type: MaterialType.card,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)), //this right here
              child: SingleChildScrollView(
                child: Container(
                  child: Wrap(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 0, bottom: 10, top: 8),
                            child: ConstrainedBox(
                              // width: width * 0.75,
                              // height: height * 0.40,
                              constraints: BoxConstraints(
                                  maxHeight: height,
                                  maxWidth: width,
                                  minWidth: width),
                              // color: Colors.yellow,
                              // padding: EdgeInsets.only(left: 17, right: 17, bottom: 8),
                              child: Card(
                                elevation: 0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      // color: Colors.blue,
                                      height: height * 0.04,
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        // alignment: Alignment.centerRight,
                                        icon: Icon(
                                          Icons.close,
                                          size: 13.9,
                                          color: Colors.black,
                                          // textDirection:TextDirection.rtl
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    Center(
                                        child: Container(
                                      child: Text(
                                        'Notifications\n',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24),
                                      ),
                                    )),
                                    Container(
                                        height: height * 0.8,
                                        width: width * 0.9,
                                        child: ListView.builder(
                                            itemCount: notificationList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                width: width * 0.8,
                                                // height: height * 0.1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ExpandablePanel(
                                                    // tapHeaderToExpand: true,
                                                    header: Container(
                                                      // height: height * 0.03,
                                                      // color: Colors.pink[900],
                                                      child: Text(
                                                        ' ' +
                                                            notificationList[
                                                                index]['title'],
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    // collapsed: Text(
                                                    //  notificationList[index]
                                                    //           ['title'],
                                                    //   softWrap: true,
                                                    //   maxLines: 2,
                                                    //   overflow: TextOverflow.ellipsis,
                                                    // ),
                                                    expanded: Container(
                                                      // height: height * 0.3,
                                                      // width: width*0.7,
                                                      child: Column(
                                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Row(
                                                            // mainAxisAlignment: MainAxisAlignment.center,

                                                            children: <Widget>[
                                                              Text(
                                                                'Date',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(' : '),
                                                              Flexible(
                                                                flex: 1,
                                                                child: Text(
                                                                    notificationList[
                                                                            index]
                                                                        [
                                                                        'date']),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: <Widget>[
                                                              Text(
                                                                'Time',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(' : '),
                                                              notificationList[
                                                                              index]
                                                                          [
                                                                          'time'] !=
                                                                      ""
                                                                  ? Flexible(
                                                                      flex: 1,
                                                                      child: Text(
                                                                          notificationList[index]
                                                                              [
                                                                              'time']),
                                                                    )
                                                                  : Text(
                                                                      'Not specified',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    )
                                                            ],
                                                          ),
                                                          Container(
                                                            // width:width*0.1,
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Description',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                Text(' : '),
                                                                notificationList[index]
                                                                            [
                                                                            'notification'] !=
                                                                        ""
                                                                    ? Flexible(
                                                                        flex: 1,
                                                                        child: Text(notificationList[index]
                                                                            [
                                                                            'notification']),
                                                                      )
                                                                    : Text('')
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  List<dynamic> notificationList = [];
  fetchNotifications(context, height, width) async {
    notificationList = await Provider.of<StudentService>(context, listen: false)
        .fetchNotifications(Provider.of<LoginService>(context).userType)
        .then((response) {
      if (response != null) {
        Provider.of<StudentService>(context, listen: false).setNotifications(
            Provider.of<LoginService>(context).userId,
            Provider.of<LoginService>(context).userType);
        showAlertDialog(context, height, width, response);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink[900],
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    fetchNotifications(context, height, width);
                    setState(() {
                      Provider.of<LoginService>(context).notificationFlag = 0;
                    });
                    
                  },
                  icon: Stack(
                    children: <Widget>[
                      Icon(Icons.notifications, color: Colors.white),
                      Positioned(
                          left: 15.0,
                          child: Icon(
                            Icons.brightness_1,
                            // color:Colors.blue,
                            color: Provider.of<LoginService>(context)
                                        .notificationFlag ==
                                    '1'
                                ? Colors.blue
                                : Colors.transparent,
                            size: 9.0,
                          ))
                      // Provider.of<LoginService>(context).notificationFlag == '1'
                      //     ? Positioned(
                      //         left: 15.0,
                      //         child: Icon(
                      //           Icons.brightness_1,
                      //           color: Colors.yellow,
                      //           size: 9.0,
                      //         ))
                      //     : Text('')
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
          width: width*0.9,
            height: height * 0.75,
            child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 4 / 2,
                // padding: const EdgeInsets.only(top:8.0),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 5.0,
                // itemBuilder: (BuildContext context, int index) {
                //  return
                children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.pink[900], width: 4)),
                    child: Icon(
                      Icons.format_list_bulleted,
                      color: Colors.pink[900],
                      size: 45,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 4,
                    color: Colors.pink[900],
                  ),
               
               
                  Container(
                    decoration:
                        new BoxDecoration(color: Colors.black, boxShadow: [
                      new BoxShadow(
                          color: Colors.black,
                          blurRadius: 5.0,
                          offset: Offset(8, 8)),
                    ]),
                    width: width * 0.6,
                    height: height * 0.1,
                    child: RaisedButton(
                      color: Colors.pink[900],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            'Students\nList',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: () {
                        fetchStudentListAll();
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    decoration:
                        new BoxDecoration(color: Colors.black, boxShadow: [
                      new BoxShadow(
                          color: Colors.black,
                          blurRadius: 5.0,
                          offset: Offset(8, 8)),
                    ]),
                    width: width * 0.6,
                    height: height * 0.1,
                    child: RaisedButton(
                      color: Colors.pink[900],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                         
                          Text(
                            'Assign\nTask',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                  
                        ],
                      ),
                      onPressed: () {
                        fetchStudentList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateTask()),
                        );
                      },
                    ),
                  ),
              
                  Container(
                    width: 10,
                    height: 4,
                    color: Colors.pink[900],
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.pink[900], width: 4)),
                    child: Icon(
                    Icons.assignment,
                            color: Colors.pink[900],
                            size: 40,
                    ),
                  ),
             
                ],
              ),
              Row(
                children: <Widget>[
                   Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.pink[900], width: 4)),
                    child: Icon(
                      Icons.rate_review,
                            color: Colors.pink[900],
                            size: 40,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 4,
                    color: Colors.pink[900],
                  ),
                  Container(
                    decoration: new BoxDecoration(color: Colors.black, boxShadow: [
                      new BoxShadow(
                          color: Colors.black,
                          blurRadius: 5.0,
                          offset: Offset(8, 8)),
                    ]),
                    width: width * 0.6,
                    height: height * 0.1,
                    child: RaisedButton(
                      color: Colors.pink[900],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                         
                          Text(
                            'Student\nRating',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                     
                        ],
                      ),
                      onPressed: () {
                        fetchStudentList().then((resp) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentRating(
                                    studentList: filteredStudentList)),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ]
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     Container(
                //       width: width * 0.6,
                //       height: height * 0.05,
                //       child: RaisedButton(
                //         color: Colors.pink[900],
                //         child: Text(
                //           'Students List',
                //           style: TextStyle(color: Colors.white, fontSize: 18),
                //         ),
                //         onPressed: () {
                //           fetchStudentListAll();
                //         },
                //       ),
                //     ),
                //     Container(
                //       width: width * 0.6,
                //       height: height * 0.05,
                //       child: RaisedButton(
                //         color: Colors.pink[900],
                //         child: Text(
                //           'Assign Task',
                //           style: TextStyle(color: Colors.white, fontSize: 18),
                //         ),
                //         onPressed: () {
                //           fetchStudentList();
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => CreateTask()),
                //           );
                //         },
                //       ),
                //     ),
                //     Container(
                //       width: width * 0.6,
                //       height: height * 0.05,
                //       child: RaisedButton(
                //         color: Colors.pink[900],
                //         child: Text(
                //           'Student Rating',
                //           style: TextStyle(color: Colors.white, fontSize: 18),
                //         ),
                //         onPressed: () {
                //           fetchStudentList();
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => StudentRating(
                //                     studentList: filteredStudentList)),
                //           );
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                // }
                )),
      ),
    );
  }
}
