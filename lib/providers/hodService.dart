import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/model/mappingModel.dart';
import 'package:login/providers/hodLoginService.dart';
import 'package:http/http.dart' as http;
import 'package:login/providers/login.dart';

class StudentService with ChangeNotifier {
  List<dynamic> _items = [];
  List<GraphModel> graphList = [];
  // LoginData data;

  Future<dynamic> getStudentList() async {
    var response;
    var url = 'http://inkers.org/mapp/fetchstudents.php?id=1';
    try {
      response = await http.get(url);
      final extractedData = json.decode(response.body);
      return extractedData;
      // return _items;
    } catch (error) {
      return null;
    }
  }

  Future<dynamic> getAllMentorList() async {
    var response;
    var url = 'http://inkers.org/mapp/getallmentors.php';
    //url = 'http://onlinementoring.epizy.com/getallmentors.php';
    try {
      response = await http.get(url);
      final extractedData = json.decode(response.body);
      return extractedData;
      // return _items;
    } catch (error) {
      return null;
    }
  }

  Future<dynamic> getMentorList(className, batchName) async {
    var response;
    var url =
        'http://inkers.org/mapp/fetchmentors.php?class=$className&batch=$batchName';
    try {
      response = await http.get(url);
      final extractedData = json.decode(response.body);
      return extractedData;
      // return _items;
    } catch (error) {
      return null;
    }
  }

  Future<dynamic> assignStudentMentor(m1, m2, m3, mentorStudentList) async {
    var response;
    var returnJson;
    // var data=  MentorMapArgs.fromJson(mentorStudentList);
    var url = 'http://inkers.org/mapp/assignmentor.php?m1=$m1&m2=$m2&m3=$m3';
    try {
      response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: returnJson = json.encode(mentorStudentList),
      );
      print(returnJson);
      final extractedData = json.decode(response.body);
      return extractedData;
      // return _items;
    } catch (error) {
      return null;
    }
  }

  Future<dynamic> createMeeting(meetingData) async {
    var response;
    var returnJson;
    // var data=  MentorMapArgs.fromJson(mentorStudentList);
    var url = 'http://inkers.org/mapp/setnotification.php';
    try {
      response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: returnJson = json.encode({
          'date': meetingData.date,
          'time': meetingData.time,
          'title': meetingData.title,
          'notification': meetingData.notification,
          'flag': meetingData.flag
        }),
      );
      print(returnJson);
      final extractedData = json.decode(response.body);
      return extractedData;
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> fetchNotifications(flag) async {
    var response;
    var returnJson;
    // flag=Provider.of<LoginService>(context).userType;
    // var data=  MentorMapArgs.fromJson(mentorStudentList);
    var url = 'http://inkers.org/mapp/fetchnotifications.php?flag=$flag';
    try {
      response = await http.get(
        url,
      );
      print(returnJson);
      final extractedData = json.decode(response.body);
      return extractedData;
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> setNotifications(userId, flag) async {
    var response;
    var returnJson;

    // flag=Provider.of<LoginService>(context).userType;
    // var data=  MentorMapArgs.fromJson(mentorStudentList);
    var url =
        'http://inkers.org/mapp/setnotificationstatus.php?id=$userId&flag=$flag';
    try {
      response = await http.get(
        url,
      );
      print(returnJson);
      final extractedData = json.decode(response.body);
      return extractedData;
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> rateStudent(rateData) async {
    var response;
    var returnJson;
    // var data=  MentorMapArgs.fromJson(mentorStudentList);
    var url = 'http://inkers.org/mapp/setrating.php';
    try {
      response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: returnJson = json.encode({
          'sid': rateData.sid,
          'mid': rateData.mid,
          'month': rateData.month,
          'behaviourRating': rateData.behaviourRating,
          'attendanceRating': rateData.attendanceRating,
          'marksRating': rateData.marksRating,
          'comments': rateData.comments
        }),
      );
      print(returnJson);
      final extractedData = json.decode(response.body);
      return extractedData;
    } catch (error) {
      print(error);
    }
  }

  Future<List<GraphModel>> getRatingStudent(studentId, month) async {
    var response;
    var returnJson;
    print(month);
    // var data=  MentorMapArgs.fromJson(mentorStudentList);
    var url =
        'http://inkers.org/mapp/getrating.php?sid=$studentId&month=$month';
    try {
      response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );
      print(returnJson);
      final extractedData = json.decode(response.body);
      print(extractedData);
      graphList.clear();
      if (extractedData.isNotEmpty) {
        for (var i = 0; i < extractedData.length; i++) {
          graphList.add(GraphModel(
              0,
              extractedData[i]['month'],
              extractedData[i]['behaviourRating'],
              extractedData[i]['attendanceRating'],
              extractedData[i]['marksRating'],
              extractedData[i]['comments']));
        }
      }
      print(graphList);
      return graphList;
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> createTask(taskData, uId) async {
    var response;
    var returnJson;
    var dt = DateTime.now();
    String dtNow = dt.day.toString() +
        '-' +
        dt.month.toString() +
        '-' +
        dt.year.toString();
    // var data=  MentorMapArgs.fromJson(mentorStudentList);
    var url =
        'http://inkers.org/mapp/atask.php?task=$taskData&date=$dtNow&mid=$uId';
    // var url;

    try {
      response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );
      print(returnJson);
      final extractedData = json.decode(response.body);
      return extractedData;
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> fetchTasks(sid) async {
    var response;
    var returnJson;
    // flag=Provider.of<LoginService>(context).userType;
    // var data=  MentorMapArgs.fromJson(mentorStudentList);
    var url = 'http://inkers.org/mapp/ftask.php?sid=$sid';
    try {
      response = await http.get(
        url,
      );
      print(returnJson);
      final extractedData = json.decode(response.body);
      return extractedData;
    } catch (error) {
      print(error);
    }
  }
}
