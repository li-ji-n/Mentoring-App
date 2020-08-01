import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/providers/hodLoginService.dart';
import 'package:http/http.dart' as http;

class LoginService with ChangeNotifier {
  List<LoginData> _items = [];
  LoginData data;
  var userType;
  var userName;
  var mentorName;
  var mentorId;
  var userId;
  var notificationFlag;
  var obj;
  Future<dynamic> login(username, password) async {
    var response;
    var url = 'http://inkers.org/mapp/login.php';
    try {
      response = await http.post(url,

          // headers: {
          //   "Access-Control-Allow-Origin":"*", // Required for CORS support to work
          //   "Accept": "application/json"
          // },
          body: ({
            'username': username.toString().toLowerCase(),
            'password': password.toString().toLowerCase(),
          }));
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      obj = extractedData;
      if (response.statusCode == 200) {
        if (extractedData['status'] == 'true') {
          mentorId = extractedData['id'];
          userName = extractedData['name'];
          userType = extractedData['type'];
          userId = extractedData['id'];
          notificationFlag = extractedData['nflag'];
          mentorName = extractedData['mentorName'];
          return extractedData['type'];
        } else if (extractedData['status'] == 'false') {
          return 'error';
        }
      } else {
        return 'error';
      }
    } catch (error) {
      print(error);
      return 'error';
    }
  }
}
