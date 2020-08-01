import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:login/model/mappingModel.dart';
import 'package:login/providers/hodService.dart';
import 'package:provider/provider.dart';

class StudentReport extends StatefulWidget {
  final List<GraphModel> graphList;
  final student;
  StudentReport({this.graphList, this.student});
  @override
  _StudentReportState createState() => _StudentReportState();
}

class _StudentReportState extends State<StudentReport> {
  bool viewComments = false;
  String commentsVal;
  bool behaviourGraphFlag = false;
  bool marksGraphFlag = false;
  bool attendanceGraphFlag = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    behaviourGraphFlag = true;
    viewComments = false;
    calGraphFunc();
  }

  var data;
  List<GraphModel> graphFinalList = [];
  int calcMonthId(month) {
    if (month == 'Jan') {
      return 1;
    } else if (month == 'Feb') {
      return 2;
    } else if (month == 'Mar') {
      return 3;
    } else if (month == 'Apr') {
      return 4;
    } else if (month == 'May') {
      return 5;
    } else if (month == 'Jun') {
      return 6;
    } else if (month == 'Jul') {
      return 7;
    } else if (month == 'Aug') {
      return 8;
    } else if (month == 'Sep') {
      return 9;
    } else if (month == 'Oct') {
      return 10;
    } else if (month == 'Nov') {
      return 11;
    } else if (month == 'Dec') {
      return 12;
    }
  }

  calGraphFunc() {
    bool hasMaxVal = false;
    GraphModel val = new GraphModel(0, '', '', '', '', '');
    // for(var i=0;i<widget.graphList.length;i++){
    //     val.id = calcMonthId(widget.graphList[i].month);
    //       val.month = widget.graphList[i].month;
    //       val.rate = widget.graphList[i].rate;
    //        graphFinalList=;
    // }

    widget.graphList.forEach((element) {
      element.id = calcMonthId(element.month);
    });
    graphFinalList = widget.graphList;
    // widget.graphList.forEach((item) => {
    //       val.id = calcMonthId(item.month),
    //       val.month = item.month,
    //       val.rate = item.rate,
    //   graphFinalList.add(val)
    //     });

    for (var i = 0; i < 12; i++) {
      GraphModel item = new GraphModel(0, '', '', '', '', '');

      if (!graphFinalList.any((ele) => ele.month == 'Jan')) {
        item.id = 1;
        item.month = 'Jan';
        item.behaviourRate = '0';
        item.attendanceRate = '0';
        item.marksRate = '0';

        graphFinalList.add(item);
      } else if (!graphFinalList.any((ele) => ele.month == 'Feb')) {
        item.id = 2;
        item.month = 'Feb';
        item.behaviourRate = '0';
        item.attendanceRate = '0';
        item.marksRate = '0';
        graphFinalList.add(item);
      } else if (!graphFinalList.any((ele) => ele.month == 'Mar')) {
        item.id = 3;
        item.month = 'Mar';
        item.behaviourRate = '0';
        item.attendanceRate = '0';
        item.marksRate = '0';
        graphFinalList.add(item);
      } else if (!graphFinalList.any((ele) => ele.month == 'Apr')) {
        item.id = 4;
        item.month = 'Apr';
        item.behaviourRate = '0';
        item.attendanceRate = '0';
        item.marksRate = '0';
        graphFinalList.add(item);
      } else if (!graphFinalList.any((ele) => ele.month == 'May')) {
        item.id = 5;
        item.month = 'May';
        item.behaviourRate = '0';
        item.attendanceRate = '0';
        item.marksRate = '0';
        graphFinalList.add(item);
      } else if (!graphFinalList.any((ele) => ele.month == 'Jun')) {
        item.id = 6;
        item.month = 'Jun';
        item.behaviourRate = '0';
        item.attendanceRate = '0';
        item.marksRate = '0';
        graphFinalList.add(item);
      } else if (!graphFinalList.any((ele) => ele.month == 'Jul')) {
        item.id = 7;
        item.month = 'Jul';
        item.behaviourRate = '0';
        item.attendanceRate = '0';
        item.marksRate = '0';
        graphFinalList.add(item);
      } else if (!graphFinalList.any((ele) => ele.month == 'Aug')) {
        item.id = 8;
        item.month = 'Aug';
        item.behaviourRate = '0';
        item.attendanceRate = '0';
        item.marksRate = '0';
        graphFinalList.add(item);
      } else if (!graphFinalList.any((ele) => ele.month == 'Sep')) {
        item.id = 9;
        item.month = 'Sep';
        item.behaviourRate = '0';
        item.attendanceRate = '0';
        item.marksRate = '0';
        graphFinalList.add(item);
      } else if (!graphFinalList.any((ele) => ele.month == 'Oct')) {
        item.id = 10;
        item.month = 'Oct';
        item.behaviourRate = '0';
        item.attendanceRate = '0';
        item.marksRate = '0';
        graphFinalList.add(item);
      } else if (!graphFinalList.any((ele) => ele.month == 'Nov')) {
        item.id = 11;
        item.month = 'Nov';
        item.behaviourRate = '0';
        item.attendanceRate = '0';
        item.marksRate = '0';
        graphFinalList.add(item);
      } else if (!graphFinalList.any((ele) => ele.month == 'Dec')) {
        item.id = 12;
        item.month = 'Dec';
        item.behaviourRate = '0';
        item.attendanceRate = '0';
        item.marksRate = '0';
        graphFinalList.add(item);
      }
    }

    data = graphFinalList..sort((a, b) => a.id.compareTo(b.id));
    print(graphFinalList);
  }

  @override
  Widget build(BuildContext context) {
    _onSelectionChanged(charts.SelectionModel model) {
      final selectedDatum = model.selectedDatum;

      DateTime time;
      final measures = <String, num>{};

      if (selectedDatum.isNotEmpty) {
        print(selectedDatum.first.datum.comments);
        commentsVal = selectedDatum.first.datum.comments != ''
            ? selectedDatum.first.datum.comments
            : '';
      }
      setState(() {
        viewComments = true;
      });
    }

    // var data = widget.graphList;

    // x.forEach((item) {
    //   if (item.month == 'Jan') {
    //     data.add(item);
    //   }
    // });

    Widget showGraph(width, chartWidget) {
      if (widget.graphList.length > 0 && behaviourGraphFlag == true) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.grey[200],
                ),
                width: width * 0.95,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          child: Text(
                        'Max Value: 5',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.start,
                      )),
                    ),
                    chartWidget,
                    Text(
                      '* Tap on graph bar to view comments\n',
                      style:
                          TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              viewComments && commentsVal != ''
                  ? Container(
                      width: width * 0.8,
                      // color: Colors.yellowAccent  ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Comments',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          Text(
                            commentsVal,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  : Text('No Comments added')
            ],
          ),
        );
      } else if (marksGraphFlag == true) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.pink[50],
                ),
                width: width * 0.95,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          child: Text(
                        'Max Value: 50',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.start,
                      )),
                    ),
                    chartWidget,
                    Text(
                      '* Tap on graph bar to view comments\n',
                      style:
                          TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              viewComments && commentsVal != ''
                  ? Container(
                      width: width * 0.8,
                      // color: Colors.yellowAccent  ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Comments',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          Text(
                            commentsVal,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  : Text('No Comments added')
            ],
          ),
        );
      } else if (attendanceGraphFlag == true) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.blue[50],
                ),
                width: width * 0.95,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          child: Text(
                        'Max Value: 100%',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.start,
                      )),
                    ),
                    chartWidget,
                    Text(
                      '* Tap on graph bar to view comments\n',
                      style:
                          TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              viewComments && commentsVal != ''
                  ? Container(
                      width: width * 0.8,
                      // color: Colors.yellowAccent  ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Comments',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          Text(
                            commentsVal,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  : Text('No Comments added')
            ],
          ),
        );
      } else {
        return Container(child: Text('\n\n\n No data to show'));
      }
    }

    int measureVal(rate) {
      if (behaviourGraphFlag == true) {
        return int.parse(rate.behaviourRate);
      } else if (attendanceGraphFlag == true) {
        return int.parse(rate.attendanceRate);
      } else if (marksGraphFlag == true) {
        return int.parse(rate.marksRate);
      }
    }

    print(data);
    var series = [
      charts.Series(
        domainFn: (GraphModel mnth, _) => mnth.month,
        measureFn: (GraphModel rate, _) => measureVal(rate),
        colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault.darker,
        id: 'performance',
        data: data,
      ),
    ];
    var chart = charts.BarChart(
      series,
      animate: true,
      selectionModels: [
        new charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            changedListener: _onSelectionChanged
            // r: _onSelectionChanged,
            )
      ],
    );
    var chartWidget = Padding(
      padding: EdgeInsets.all(20.0),
      child: SizedBox(
        height: 200.0,
        child: chart,
      ),
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.pink[900],
        ),
        body: SingleChildScrollView(
          child: Container(
            // color: Colors.yellow,
            width: width,
            height: height * 0.9,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '\nREPORT',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                        width: width * 0.9,
                        // height: height*0.5,
                        child: Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              Text(
                                'Name :  ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  widget.student['name'] != null
                                      ? widget.student['name']
                                      : '',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              )
                            ]),
                            Text('\n'),
                            Row(children: <Widget>[
                              Text('Class :  ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                              Text(
                                widget.student['class'] != null
                                    ? widget.student['class']
                                    : widget.student['className'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ]),
                            Text('\n'),
                            Row(children: <Widget>[
                              Text('Batch :  ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                              Text(
                                widget.student['batchName'] != null
                                    ? widget.student['batchName']
                                    : widget.student['batch'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ]),
                            Text('\n'),
                            Row(children: <Widget>[
                              widget.student['mentorName'] != null
                                  ? Text(
                                      'Mentor :  ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    )
                                  : Text(''),
                              widget.student['mentorName'] != null
                                  ? Flexible(
                                      flex: 1,
                                      child: Text(
                                        widget.student['mentorName'],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    )
                                  : Text('')
                            ]),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          child: Text('Behaviour'),
                          onPressed: () {
                            setState(() {
                              behaviourGraphFlag = true;
                              attendanceGraphFlag = false;
                              marksGraphFlag = false;
                            });
                          },
                        ),
                        RaisedButton(
                          child: Text('Attendance'),
                          onPressed: () {
                            setState(() {
                              behaviourGraphFlag = false;
                              attendanceGraphFlag = true;
                              marksGraphFlag = false;
                            });
                          },
                        ),
                        RaisedButton(
                          child: Text('Marks'),
                          onPressed: () {
                            setState(() {
                              behaviourGraphFlag = false;
                              attendanceGraphFlag = false;
                              marksGraphFlag = true;
                            });
                          },
                        ),
                      ],
                    ),
                    showGraph(width, chartWidget)
                  ],
                ),
                Container()
              ],
            ),
          ),
        ));
  }
}
