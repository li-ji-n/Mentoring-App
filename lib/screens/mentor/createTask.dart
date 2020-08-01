import 'package:flutter/material.dart';
import 'package:login/providers/hodService.dart';
import 'package:login/providers/login.dart';
import 'package:provider/provider.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  var taskText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[900],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Text(
                  'ASSIGN TASK',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    'Task : ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  )),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    borderOnForeground: true,
                    elevation: 1.0,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (val) {},
                        style: TextStyle(fontSize: 20),
                        controller: taskText,
                        maxLines: 4,
                        decoration: InputDecoration.collapsed(hintText: "  "),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                //  color: Colors.pink[900],
                child: RaisedButton(
                  onPressed: () async {
                    await Provider.of<StudentService>(context, listen: false)
                        .createTask(taskText.text,Provider.of<LoginService>(context).userId);
                        Navigator.pop(context);
                  },
                  child: Text(
                    'Create',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  color: Colors.pink[900],
                ),
              ),
            ],
          ),
        ));
  }
}
