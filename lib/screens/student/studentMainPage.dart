import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:login/providers/hodService.dart';
import 'package:login/providers/login.dart';
import 'package:login/screens/student/studentLogin.dart';
import 'package:login/screens/student/tasks.dart';
import 'package:login/screens/studentReports/studentReportFile.dart';
import 'package:provider/provider.dart';
import '../student/studentProfile.dart';
// import '..screens/studentsList.dart';

// import '../main.dart';

class MainPageStudent extends StatefulWidget {
  MainPageStudent({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MainPageStudent> {
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
                child: Wrap(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 0, bottom: 8),
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
                              Container(
                                  height: height * 0.8,
                                  width: width * 0.9,
                                  child: ListView.builder(
                                      itemCount: notificationList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          width: width * 0.8,
                                          // height: height * 0.1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ExpandablePanel(
                                              // tapHeaderToExpand: true,
                                              header: Container(
                                                height: height * 0.05,
                                                color: Colors.pink[900],
                                                child: Text(
                                                  notificationList[index]
                                                      ['title'],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
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
                                                        Text('Date'),
                                                        Text(':'),
                                                        Text(notificationList[
                                                            index]['date'])
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text('Time'),
                                                        Text(':'),
                                                        notificationList[index]
                                                                    ['time'] !=
                                                                ""
                                                            ? Text(
                                                                notificationList[
                                                                        index]
                                                                    ['time'])
                                                            : Text(
                                                                'Not specified',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )
                                                      ],
                                                    ),
                                                    Container(
                                                      // width:width*0.1,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text('Description'),
                                                          Text(':'),
                                                          notificationList[
                                                                          index]
                                                                      [
                                                                      'notification'] !=
                                                                  ""
                                                              ? Text(notificationList[
                                                                      index][
                                                                  'notification'])
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
              ),
            ),
          );
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
              // IconButton(
              //   icon: const Icon(Icons.calendar_today),
              //   tooltip: 'Master Calender',
              //   onPressed: () {},
              // ),
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
                                StudentLoginPage()),
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
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(''),
              Container(
                // color: Colors.yellowAccent,
                width: width,
                height: height * 0.5,
                child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 4 / 2,
                  // padding: const EdgeInsets.only(top:8.0),
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 5.0,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.pink[900],width: 4)),
                          child: Icon(Icons.library_books,
                              color: Colors.pink[900], size: 45),
                        ),
                        Container(
                          width: 10,
                          height: 4,
                          color: Colors.pink[900],
                        ),
                        
                        
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 8.0,
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
                                  'View Report',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                  textAlign: TextAlign.center,
                                ),
                               
                              ],
                            ),
                            onPressed: () {
                              print(Provider.of<LoginService>(context)
                                  .obj['name']);
                              Provider.of<StudentService>(context)
                                  .getRatingStudent(
                                      Provider.of<LoginService>(context).userId,
                                      '')
                                  .then((resp) {
                                print(Provider.of<LoginService>(context)
                                    .userName);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentReport(
                                          graphList: resp,
                                          student:
                                              Provider.of<LoginService>(context)
                                                  .obj)),
                                );
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: height*0.1,),
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 8.0,
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
                                  'View Tasks',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                  textAlign: TextAlign.center,
                                ),
                          
                              ],
                            ),
                            onPressed: () async {
                              await Provider.of<StudentService>(context,
                                      listen: false)
                                  .fetchTasks(
                                      Provider.of<LoginService>(context).userId)
                                  .then((response) {
                                if (response != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewTasks(
                                              taskList: response,
                                            )),
                                  );
                                }
                              });
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
                              border: Border.all(color: Colors.pink[900],width: 4)),
                          child: Icon(
                            Icons.assignment,
                            color: Colors.pink[900],
                            size: 45,
                          ),
                        ),
                     
                      ],
                    ),
                  ],
                ),
              ),
              Text('')
            ],
          ),
        ),
      ),
    );
  }
}
