import 'package:flutter/material.dart';
import 'package:login/providers/login.dart';
import 'package:login/screens/hod/hodLogin.dart';
import 'package:login/screens/hod/hodMainPage.dart';
import 'package:login/screens/hod/mappingMentorStudent.dart';
import 'package:provider/provider.dart';

class MentorDetailsPage extends StatefulWidget {
  final String mentorName;
  MentorDetailsPage({this.mentorName});
  @override
  _MentorDetailsPageState createState() => _MentorDetailsPageState();
}

class _MentorDetailsPageState extends State<MentorDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentor Details'),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFE57373),
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.transparent,
          ),
        ),
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
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: height * 0.7,
            width: width * 0.9,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/user.png"),
                  ),
                  Container(
                    // padding: EdgeInsets.only(left:25),
                    child: Table(
                        // defaultVerticalAlignment : TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            Text('Name:'),
                            Text(widget.mentorName),
                          ]),
                          TableRow(children: [
                            Text('\n'),
                              Text('')
                          ]),

                          TableRow(children: [
                            Text('Subject:'),
                            Text('subjectName'),
                          ]),
                          TableRow(children: [
                            Text('\n'),
                            Text(''),
                          ]),
                          TableRow(children: [
                            Text('Tutor Of Class:'),
                             Text('nameOfClass'),
                          ])
                          // TableRow(children: [
                          //   Row(children:[
                          //     Text('Name:'),

                          //   ]),
                          //   Row(children:[
                          //     Text('Subject:'),

                          //   ]),
                          //   Row(children:[
                          //     Text('Tutor Of Class:'),

                          //   ])

                          // ])
                        ]),
                    // child: RichText(
                    //   textAlign: TextAlign.left,
                    //   text: TextSpan(children: [
                    //     TextSpan(
                    //         text: 'Name:\t\t',
                    //         style: TextStyle(color: Colors.black)),
                    //     TextSpan(
                    //         text: widget.mentorName,
                    //         style: TextStyle(color: Colors.black))
                    //   ]),
                    // ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
