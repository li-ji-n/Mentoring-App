import 'package:flutter/material.dart';
import 'package:login/dummyData.dart/dummyDt.dart';
import 'package:login/model/mappingModel.dart';
import 'package:login/providers/hodService.dart';
import 'package:login/providers/login.dart';
import 'package:login/screens/hod/eventCalendar.dart';
import 'package:login/screens/hod/hodLogin.dart';
import 'package:login/screens/hod/mappingMentorStudent.dart';
import 'package:login/screens/hod/mentorList.dart';
import 'package:login/screens/hod/viewStudentList.dart';
import 'package:login/screens/meetingSchedule.dart/calenderEvents.dart';
import 'package:login/screens/meetingSchedule.dart/meetings.dart';
import 'package:login/screens/mentor/mentorDetailsPage.dart';
import 'package:intl/intl.dart';
import 'package:login/screens//mentor/studentListView.dart';

// import '../studentsList.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import '../mentor/flutter_calender_carousel.dart';

class MainPageHod extends StatefulWidget {
  MainPageHod({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MainPageHod> {
  // static List _elements = [
  //   {'name': 'CSE A', 'group': 'S1/S2'},
  //   {'name': 'CSE B', 'group': 'S1/S2'},
  //   {'name': 'CSE A', 'group': 'S3/S4'},
  //   {'name': 'CSE B', 'group': 'S3/S4'},
  //   {'name': 'CSE A', 'group': 'S5/S6'},
  //   {'name': 'CSE B', 'group': 'S5/S6'},
  //   {'name': 'CSE A', 'group': 'S7/S8'},
  //   {'name': 'CSE B', 'group': 'S7/S8'},
  // ];
  // static List mentors = [
  //   'Abu',
  //   'Nissam',
  //   'Rahul',
  //   'Sreerag',
  //   'Amrithlal',
  //   'Vishnu',
  //   'Murshid'
  // ];

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static BuildContext ctx;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  List<dynamic> event = [];
  Map<DateTime, List> mapFetch = {};
  fetchNotifications(context, height, width) async {
    MapObj obj = new MapObj();
    event = await Provider.of<StudentService>(context, listen: false)
        .fetchNotifications(1);
    for (int i = 0; i < event.length; i++) {
      var dt = event[i]['date'].toString().split('-')[0] +
          ',' +
          event[i]['date'].toString().split('-')[1] +
          ',' +
          event[i]['date'].toString().split('-')[2];
      DateTime createTime = new DateFormat("yyyy,MM,dd").parse(dt.split(' ')[0]);
      var original = mapFetch[createTime];
      if (original == null) {
        if (createTime != null) {
          print("null");
          obj.name = event[i]['title'];
          createTime.isAfter(DateTime.now())
              ? obj.isDone = true
              : obj.isDone = false;
          mapFetch[createTime] = [obj];
        }
      } else {
        print(event[i]['title']);
        if (createTime != null) {
          mapFetch[createTime] = List.from(original)..addAll({obj});
        }
      }
    }
    print(mapFetch);
    if (mapFetch.isNotEmpty) {
      print('map not empty');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CalendarScreen(mapFetch: mapFetch)),
      );
    }
    // return mapFetch;
  }

  List<dynamic> filteredStudentList = [];
  List<dynamic> studentL = [];
  fetchStudentList() async {
    filteredStudentList.clear();
    await Provider.of<StudentService>(context, listen: false)
        .getStudentList()
        .then((response) {
      if (response != null) {
        studentL = response;
        studentL.forEach((item) {
          filteredStudentList.add(item);
        });
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              StudentListView(studentList: filteredStudentList)),
    );
  }

  List<dynamic> filteredMentorList = [];
  List<dynamic> mentorL = [];
  fetchMentorList() async {
    filteredStudentList.clear();
    await Provider.of<StudentService>(context, listen: false)
        .getAllMentorList()
        .then((response) {
      if (response != null) {
        mentorL = response;
        mentorL.forEach((item) {
          filteredMentorList.add(item);
        });
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MentorList(mentorList: filteredMentorList)),
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('HOD Login'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink[900],
        actions: <Widget>[
          Row(
            // children: <Widget>[
            //   IconButton(
            //     onPressed: () {
            //       fetchNotifications(context, height, width);
            //     },
            //     icon: Icon(Icons.calendar_today, color: Colors.white),
            //   )
            // ],
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

      body: Center(
        child: Container(
          width: width * 0.9,
          height: height * 0.8,
          child: GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 4 / 2,
            // padding: const EdgeInsets.only(top:8.0),
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 5.0,
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
                    child: CircleAvatar(
                      radius: 47,
                      // foregroundColor: Colors.pink[900],
                      child: CircleAvatar(
                          radius: 47,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: AssetImage("assets/mapping.png")),
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
                      child: Text(
                        'Mentor-Student Mapping',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapStudentMentor(
                                    fromStudent: 'false',
                                  )),
                        );
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
                      child: Text(
                        'Schedule Meetings',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Meetings()),
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
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.pink[900],
                      child: CircleAvatar(
                          radius: 47,
                          // foregroundColor: Colors.white,
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.pink[900],
                          backgroundImage: AssetImage("assets/meetings.png")),
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
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.pink[900],
                      child: CircleAvatar(
                          radius: 49,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.pink[900],
                          backgroundImage: AssetImage("assets/teacher.png")),
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
                      child: Text(
                        'View Mentors',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        fetchMentorList();
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
                      child: Text(
                        'View Students',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MapStudentMentor(fromStudent: 'true')),
                        );
                        // fetchStudentList();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => MapStudentMentor()),
                        // );
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
                    child: CircleAvatar(
                      radius: 50,
                      // backgroundColor: Colors.pink[900],
                      child: CircleAvatar(
                          radius: 47,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.pink[900],
                          backgroundImage: AssetImage("assets/student.png")),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //       Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => MapStudentMentor()),
      //                   );
      //   },
      //   child: Icon(Icons.add),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text('Home'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       title: Text('Mentor List'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.school),
      //       title: Text('Student List'),
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.pink[900][300],
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
