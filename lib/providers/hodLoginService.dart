import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:login2/model/loginModel.dart';
import 'package:http/http.dart' as http;
// import 'package:firebase_auth/firebase_auth.dart';

class CommonService with ChangeNotifier {
  List<LoginData> _items = [];
  LoginData data;

  

  //add user
  Future<void> addUser() async {
    var response;
    var url = 'https://group6-d6dbb.firebaseio.com/users.json';
    try {
      response = await http.post(
        url,
        body: json.encode({
          'id': 7,
          'name': 'Arjun',
          'userName': 'STUDENT04',
          'password': 'MES16CS020',
          'roleId': 3
        }),
      );
    } catch (error) {
      print(error);
    }

    print(response.statusCode);
  }

//add Roles

  Future<void> addRole() async {
    var url = 'https://group6-d6dbb.firebaseio.com/roles.json';
    List<dynamic> roleData = [];
    roleData = [
      {'name': 'HOD'},
      {'name': 'Mentor'},
      {'name': 'Student'}
    ];
    var returnJson;
    notifyListeners();
    try {
      final response = await http.post(
        url,
        body: returnJson = json.encode(
          {'id': '3', 'name': 'Student'},
          // {'id': '2', 'name': 'Mentor'},
          // {'id': '3', 'name': 'Student'},
          // 'password': userInfo.password,
        ),
      );

      print(response);
      print(returnJson);
    } catch (error) {
      print(error);
    }
  }
}

class LoginData {
  int id;
  String userName;
  String password;
  LoginData({this.id, this.userName, this.password});
}

class RoleData {
  int id;
  String name;

  RoleData({this.id, this.name});
}
