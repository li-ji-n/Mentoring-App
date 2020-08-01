import 'package:flutter/material.dart';
import 'package:login/providers/hodLoginService.dart';
import 'package:login/providers/login.dart';
import 'package:login/providers/navigationSwitchFile.dart';
import 'package:provider/provider.dart';
// import 'package:login/mentor/mentorMainPage.dart';
import './mentorMainPage.dart';

class MentorLoginPage extends StatelessWidget {
  TextEditingController userNameController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();
  LoginData data = new LoginData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("Login Page"),
          backgroundColor: Colors.pink[900],
        ),
        body: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 5),
              SizedBox(
                height: 130.0,
                width: 130.0,
                child: Image(image: AssetImage("assets/login.png")),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 300, // hard coding child width
                height: 50,
                child: TextField(
                  controller: userNameController,
                  obscureText: false,
                  decoration: new InputDecoration(
                    fillColor: Colors.white,
                    // Colors.pink[900].withOpacity(0.2),
                    filled: true,
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0),
                      ),
                    ),
                    labelText: 'Username',
                    labelStyle:
                        TextStyle(color: Colors.pink[900], fontSize: 17.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 300, // hard coding child width
                height: 50,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: new InputDecoration(
                    fillColor: Colors.white,
                    // Colors.pink[900].withOpacity(0.2),
                    filled: true,
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0),
                      ),
                    ),
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Colors.pink[900], fontSize: 17.0),
                  ),
                ),
              ),
              SizedBox(height: 25),
              SizedBox(
                 width: 150,
                height: 50,
                child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      side: BorderSide(color: Colors.pink[900]),
                    ),
                    color: Colors.pink[900],
                    textColor: Colors.white,
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async {
                      data.userName = userNameController.text;
                      data.password = passwordController.text;
                      await Provider.of<LoginService>(context, listen: false)
                          .login(data.userName, data.password)
                          .then((resp) {
                        if (resp == '1') {
                          navigateFunc(resp, context);
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Invalid Credential'),
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.pink[900],
                          ));
                        }
                      });
                    }),
              ),
              SizedBox(width: 500),
            ],
          ),
        ));
  }
}
