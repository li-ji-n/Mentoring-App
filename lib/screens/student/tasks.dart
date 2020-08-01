import 'package:flutter/material.dart';

class ViewTasks extends StatefulWidget {
  final List<dynamic> taskList;

  ViewTasks({this.taskList});
  @override
  _ViewTasksState createState() => _ViewTasksState();
}

class _ViewTasksState extends State<ViewTasks> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.pink[900],title: Text('Tasks',style:TextStyle(color: Colors.white,fontSize: 22)),),
      body: Column(
        children: <Widget>[
          // Text(
          //   '\n Tasks',
          //   style: TextStyle(color: Colors.black, fontSize: 25),
          // ),

          SizedBox( height: height * 0.05,),
          Center(
            child: Container(
              decoration: BoxDecoration(border:Border.all(color:Colors.black)),
              padding: EdgeInsets.only(left:15,right: 15,top:5),
              height: height * 0.8,
              width: width*0.95,
              child: ListView.builder(
                  itemCount: widget.taskList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation:5 ,
                      shadowColor: Colors.pink[900],
                      // borderOnForeground: true,
                      
                      child: Padding(
                        padding: const EdgeInsets.only(left:10,top: 5,bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              
                              widget.taskList[index]['task'],
                              style: TextStyle(color: Colors.black, fontSize: 18),textAlign: TextAlign.left,
                            ),
                            Text('Created Date: ' + widget.taskList[index]['date'],
                                style:
                                    TextStyle(color: Colors.black, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
