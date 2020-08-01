import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login/model/ratingModel.dart';
import 'package:login/providers/hodService.dart';
import 'package:login/providers/login.dart';
import 'package:provider/provider.dart';

class StudentRating extends StatefulWidget {
  List<dynamic> studentList;
  StudentRating({this.studentList});

  @override
  _StudentRatingState createState() => _StudentRatingState();
}

class _StudentRatingState extends State<StudentRating> {
  AutoCompleteTextField searchTextField;
  var marks = TextEditingController();
  var attendance = TextEditingController();
  TextEditingController _controller = TextEditingController();
  var comments = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<dynamic>> key = new GlobalKey();
  RatingModel ratingModel = new RatingModel();
  double ratingVal;
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

  rateStudent() async {
    await Provider.of<StudentService>(context, listen: false)
        .rateStudent(ratingModel)
        .then((response) {
      if (response != null) {
        selectedMonth = null;
        searchTextField.textField.controller.text = null;
        comments.text = null;
        ratingVal = null;
        setState(() {
          ratingModel = new RatingModel();
        });
        // print(ratingModel);
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    ratingModel.mid = Provider.of<LoginService>(context).userId;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          // padding: EdgeInsets.only(left:6,right:2),
          width: width,
          child: Center(
            child: Container(
                height: height * 0.9,
                width: width * 0.95,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.pink[900], width: 2),
                    boxShadow: [
                      new BoxShadow(
                          color: Colors.pink[900],
                          blurRadius: 4.0,
                          offset: Offset(6, 6)),
                    ]),

                // padding: EdgeInsets.only(left:6,right:2),

                child: Container(
                  // height: height*0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('Student :', style: TextStyle(fontSize: 20)),
                          Container(
                            height: height * 0.15,
                            width: width * 0.5,
                            child: Center(
                              child: searchTextField =
                                  AutoCompleteTextField<dynamic>(
                                suggestionsAmount: 5,
                                controller: _controller,
                                key: key,
                                style: new TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  // decoration: TextDecoration.underline,
                                  // decorationStyle:TextDecorationStyle.dotted,
                                  // decorationColor: Colors.white
                                ),
                                decoration: new InputDecoration(
                                  hintText: 'Tap Here',
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Proxima Nova Rg',
                                      fontStyle: FontStyle.normal,
                                      // decorationStyle: ,
                                      fontSize: 15.0),
                                ),
                                textChanged: (_) {
                                  //
                                },

                                suggestions: widget.studentList,
                                itemFilter: (item, query) {
                                  return item['name']
                                      .toLowerCase()
                                      .startsWith(query.toLowerCase());
                                },
                                itemSorter: (a, b) {
                                  return a['name'].compareTo(b['name']);
                                },
                                itemSubmitted: (item) {
                                  setState(() {
                                    searchTextField.textField.controller.text =
                                        item['name'];
                                    ratingModel.sid = item['id'];
                                  });
                                },
                                // submitOnSuggestionTap: true,

                                itemBuilder: (context, item) {
                                  return Container(
                                    // alignment: Alignment.centerLeft,
                                    //  color:Colors.green,
                                    // color: Color(0xff253746),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          // item != null
                                          //     ?
                                          RichText(
                                              text: TextSpan(
                                                  text: item['name'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15.0,
                                                      fontFamily:
                                                          'Proxima Nova Rg'),
                                                  children: []))
                                          //:
                                          // Text(noMatchFunc(),
                                          //     style: TextStyle(
                                          //         color: Colors.white54,
                                          //         fontSize: 24.0,
                                          //         fontWeight:
                                          //             FontWeight.normal,
                                          //         fontFamily:
                                          //             'Proxima Nova Rg'))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                clearOnSubmit: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Month :',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            ' ',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.start,
                          ),
                          Container(
                            width: width * 0.45,
                            child: new DropdownButton<String>(
                              value: selectedMonth,
                              hint: Container(
                                width: width * 0.3,
                                child: Text(
                                  'Choose Month',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              items: monthList.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(
                                    value,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedMonth = value;
                                  ratingModel.month = selectedMonth;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text('Behaviour Rating :',
                                  style: TextStyle(fontSize: 20)),
                              Text(
                                ' ',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.start,
                              ),
                              RatingBar(
                                initialRating: 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  size: 2,
                                  color: Colors.pink[900],
                                ),
                                onRatingUpdate: (ratingVal) {
                                  setState(() {
                                    ratingModel.behaviourRating = ratingVal;
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Attendance Rating :',
                                  style: TextStyle(fontSize: 20)),
                              Text(
                                '  ',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.start,
                              ),
                              Expanded(
                                child: TextField(
                                  onChanged: (val) {
                                    setState(() {
                                      ratingModel.attendanceRating =
                                          double.parse(val);
                                    });
                                  },
                                  // style: TextStyle(fontSize: 30),
                                  controller: attendance,
                                  maxLines: 1,
                                  decoration: new InputDecoration(
                                      hintText: " ",
                                      labelText: "",
                                      labelStyle: new TextStyle(
                                          color: const Color(0xFF424242)),
                                      border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.black))),
                                ),
                              ),
                              Text(
                                '%',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text('Marks :', style: TextStyle(fontSize: 20)),
                              Text('MarksRating :',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.transparent)),
                              Expanded(
                                child: TextField(
                                  onChanged: (val) {
                                    ratingModel.marksRating = double.parse(val);
                                    // ratingModel.marksRating=marks.;
                                  },
                                  decoration: new InputDecoration(
                                      hintText: " ",
                                      labelText: "",
                                      labelStyle: new TextStyle(
                                          color: const Color(0xFF424242)),
                                      border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.black))),
                                  controller: marks,
                                  maxLines: 1,
                                ),
                              ),
                               Text(
                                '%',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.transparent
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Comments :', style: TextStyle(fontSize: 20)),
                          Container(
                            width: width * 0.5,
                            child: Card(
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
                                  onChanged: (val) {
                                    setState(() {
                                      ratingModel.comments = val;
                                    });
                                  },
                                  style: TextStyle(fontSize: 20),
                                  controller: comments,
                                  maxLines: 3,
                                  decoration:
                                      InputDecoration.collapsed(hintText: ""),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          child: ratingModel.sid != null &&
                                  ratingModel.mid != null &&
                                  ratingModel.month != null &&
                                  ratingModel.behaviourRating != null &&
                                  ratingModel.attendanceRating != null &&
                                  ratingModel.marksRating != null
                              ? RaisedButton(
                                  color: Colors.pink[900],
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    ratingModel.mid =
                                        Provider.of<LoginService>(context)
                                            .userId;
                                    rateStudent();
                                  },
                                )
                              : RaisedButton(
                                  color: Colors.grey,
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  onPressed: () {},
                                ))
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
