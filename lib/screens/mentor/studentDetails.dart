import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:login/model/mappingModel.dart';
import 'package:login/providers/hodService.dart';
import 'package:login/screens/studentReports/studentReportFile.dart';
import 'package:provider/provider.dart';

class StudentDetails extends StatefulWidget {
  final student;

  StudentDetails({this.student});
  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  List<String> monthList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String selectedMonth;
  AutoCompleteTextField searchTextField;
  TextEditingController _controller = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<dynamic>> key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.pink[900],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text(
              //       'Month :',
              //       style: TextStyle(fontSize: 20),
              //       // textAlign: TextAlign.start,
              //     ),
              //     Text(
              //       '  ',
              //       style: TextStyle(fontSize: 20),
              //       textAlign: TextAlign.start,
              //     ),
              //     Container(
              //       width: width * 0.45,
              //       child: new DropdownButton<String>(
              //         value: selectedMonth,
              //         hint: Container(
              //           width: width * 0.3,
              //           child: Text(
              //             'Choose Month',
              //             style: TextStyle(fontSize: 15),
              //           ),
              //         ),
              //         items: monthList.map((String value) {
              //           return new DropdownMenuItem<String>(
              //             value: value,
              //             child: new Text(value),
              //           );
              //         }).toList(),
              //         onChanged: (value) {
              //           setState(() {
              //             selectedMonth = value;
              //           });
              //         },
              //       ),
              //     ),
              //   ],
              // ),

              RaisedButton(
                color: Colors.pink[900],
                child: Text(
                  'Generate Report',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Provider.of<StudentService>(context)
                      .getRatingStudent(widget.student['id'], selectedMonth)
                      .then((resp) {
                    print(resp.reversed);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentReport(graphList: resp,student:widget.student)),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
