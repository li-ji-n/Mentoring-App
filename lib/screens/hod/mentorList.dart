import 'package:flutter/material.dart';

class MentorList extends StatefulWidget {
  final List<dynamic> mentorList;
  MentorList({this.mentorList});
  @override
  _MentorListState createState() => _MentorListState();
}

class _MentorListState extends State<MentorList> {
  @override
  Widget build(BuildContext context) {
       var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        child: widget.mentorList.length > 0
            ? ListView.builder(
                itemCount: widget.mentorList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => StudentDetails(student: widget.studentList[index])),
                        // );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading:  CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.pink[900],
                            child: CircleAvatar(
                              radius: 25,
                              foregroundColor: Colors.transparent,
                              backgroundImage: AssetImage("assets/user.png"),
                              //  child: Image.asset('assets/user.png'),
                            ),
                          ),
                        title: Text(widget.mentorList[index]['name']),
                        // trailing: Icon(Icons.arrow_forward_ios),
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
    );
  }
}
