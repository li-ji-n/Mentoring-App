import 'package:flutter/material.dart';
import 'dart:convert';
class StudentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Mentoring"),
          backgroundColor: Color(0xFFE57373),
        ),
        body: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              var showData = json.decode(snapshot.data);
              return ListView.builder(
                itemCount: showData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: InkWell(
                      onTap: () {
                    },
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(showData[index]['picture']),
                        ),
                        title: Text(showData[index]['name']),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
              );
            },
            future:
                DefaultAssetBundle.of(context).loadString("assets/data.json"),
          ),
        ),
      ),
    );
  }
}

class User {
  String picture;
  String name;
  String bio;

  User({this.picture, this.name, this.bio});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      picture: json['picture'] as String,
      name: json['name'] as String,
      bio: json['bio'] as String,
    );
  }
}

class UserList {
  List<User> users;

  UserList({this.users});
}