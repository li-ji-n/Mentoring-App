import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:login/providers/login.dart';
import 'package:login/screens/hod/hodLogin.dart';
import 'package:login/screens/mentor/flutter_calender_carousel.dart';
import 'package:login/model/meetingModel.dart';
import 'package:login/providers/hodService.dart';
import 'package:provider/provider.dart';

class Meetings extends StatefulWidget {
  @override
  _MeetingsState createState() => _MeetingsState();
}

class _MeetingsState extends State<Meetings> {
  String _date = "Not set";
  String _time = "Not set";
  MeetingModel meetingModel = new MeetingModel();
  var topicText = TextEditingController();
  var descText = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));
  DateTime _selectedFromDate;
  TimeOfDay timePicked;
  DateTime todayDate = DateTime.now();
  List<String> notifyToList = ['Mentor', 'Student'];
      String selectedVal;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Schedule Meeting'),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.pink[900],
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (context) => MentorStudentListing()),
                //   // ModalRoute.withName('/'),
                // );
              },
              child: Icon(Icons.keyboard_arrow_left)),
          actions: <Widget>[
            Row(
              children: <Widget>[],
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
                                  HodLoginPage()),
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: height * 0.1,
                ),
                Container(
                    width: width * 0.9,
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 4.0,
                          onPressed: () async {
                            _selectedFromDate = await showDatePicker(
                                context: context,
                                initialDate: todayDate,
                                firstDate: DateTime(1009),
                                lastDate: DateTime(3031),
                                builder: (context, Widget child) {
                                  return Theme(
                                      data: Theme.of(context).copyWith(
                                          applyElevationOverlayColor: false,
                                          secondaryHeaderColor:
                                              Colors.pink[900],
                                          primaryColor: Colors.pink[900]),
                                      child: child);
                                });
                            print(_selectedFromDate);
                            if (_selectedFromDate != null) {
                              setState(() {
                                _date =
                                    '${_selectedFromDate.year}-${_selectedFromDate.month}-${_selectedFromDate.day}';
                              });

                              // meetingModel.date = _selectedFromDate;
                              meetingModel.date = _date;
                            }
                            // DatePicker.showDatePicker(context,
                            //     theme: DatePickerTheme(
                            //       containerHeight: 210.0,
                            //     ),
                            //     showTitleActions: true,
                            //     minTime: DateTime(2000, 1, 1),
                            //     maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                            //   print('confirm $date');
                            //   _date = '${date.year} - ${date.month} - ${date.day}';
                            //   setState(() {});
                            // }, currentTime: DateTime.now(), locale: LocaleType.en);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.date_range,
                                            size: 18.0,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            " $_date",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "  Change",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 4.0,
                          onPressed: () {
                            // timePicked = await showTimePicker(
                            //     context: context, initialTime: TimeOfDay.now());
                            // print(timePicked);
                            // if (timePicked != null) {
                            //   _time = '${timePicked.hour} : ${timePicked.minute} ';
                            // }
                            DatePicker.showTimePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true, onConfirm: (time) {
                              print('confirm $time');
                              setState(() {
                                _time = '${time.hour}:${time.minute} ';
                                meetingModel.time = _time;
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            size: 18.0,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            " $_time",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "  Change",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                          color: Colors.white,
                        )
                      ],
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    width: width * 0.9,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width * 0.9,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Topic',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                                textAlign: TextAlign.left,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 1),
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
                                    controller: topicText,
                                    maxLines: 1,
                                    decoration:
                                        InputDecoration.collapsed(hintText: ""),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Description',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 1),
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
                                    controller: descText,
                                    maxLines: 3,
                                    decoration:
                                        InputDecoration.collapsed(hintText: ""),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Notify',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        // color: Colors.grey,
                        width: width * 0.9,

                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: new DropdownButton<String>(
                            value: selectedVal,
                            hint: Text(
                            'notify',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            items: notifyToList.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                    width: width * 0.75,
                                    child: new Text(
                                      value,
                                      style: TextStyle(color: Colors.black),
                                    )),
                              );
                            }).toList(),
                            
                            onChanged: (value) {
                              setState(() {
                                selectedVal = value;
                                if (selectedVal == 'Mentor') {
                                  meetingModel.flag = 1;
                                } else {
                                  meetingModel.flag = 2;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  //  color: Colors.pink[900],
                  child: RaisedButton(
                    onPressed: topicText.text != null && topicText.text != "" &&
                            _time != "Not Set" &&
                            _date != "Not Set" && _time !=null && _date !=null && meetingModel.flag!=null
                        ? () async {
                            meetingModel.title = topicText.text;
                            meetingModel.notification = descText.text;

                            print(meetingModel);
                            await Provider.of<StudentService>(context)
                                .createMeeting(meetingModel)
                                .then((response) {
                              if (response != null) {
                                selectedVal=null;
                                _selectedFromDate = null;
                                _time = "Not Set";
                                _date = "Not Set";
                                descText = new TextEditingController();
                                topicText = new TextEditingController();
                                Navigator.pop(context);
                              }
                            });
                          }
                        : () async {},
                    child: Text(
                      'Create',
                      style: TextStyle(
                          color: topicText.text != null && topicText.text != "" &&
                            _time != "Not Set" &&
                            _date != "Not Set" && _time !=null && _date !=null && meetingModel.flag!=null
                              ? Colors.white
                              : Colors.black,
                          fontSize: 18),
                    ),
                    color: topicText.text != null && topicText.text != "" &&
                            _time != "Not Set" &&
                            _date != "Not Set" && _time !=null && _date !=null  && meetingModel.flag!=null
                        ? Colors.pink[900]
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
