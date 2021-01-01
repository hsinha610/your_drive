import 'dart:async';
import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart';
import 'login_page_widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: LoginPage1(),
      ),
    );
  }
}

class LoginPage1 extends StatefulWidget {
  @override
  _LoginPage1State createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
  TextEditingController username_controller;
  TextEditingController password_controller;
  TextEditingController resetTextController;
  FocusNode username_focusnode;
  FocusNode password_focusnode;
  @override
  void initState() {
    username_controller = TextEditingController();
    password_controller = TextEditingController();
    resetTextController = TextEditingController();

    username_focusnode = FocusNode();
    password_focusnode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    username_focusnode.dispose();
    password_focusnode.dispose();
    super.dispose();
  }

  var diagonal;

  void validate() {
    String u = username_controller.text.toString();
    String p = password_controller.text.toString();
    if (u.isEmpty || p.isEmpty) {
      String msg = "Enter";
      if (u.isEmpty) msg += " username";
      if (p.isEmpty) msg += " password";

      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return Container(
              alignment: Alignment.center,
              color: Colors.white,
              height: diagonal / 15,
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.redAccent, fontSize: diagonal / 30),
              ),
            );
          });
    } else {
      check(context, u, p);
    }
  }

  Database db = Database();
  void getdata() async {
    db.prefs = await SharedPreferences.getInstance();
  }

  void check(BuildContext context, String u, String p) {
    db.kusername = db.prefs.getStringList(db.userskey);
    db.kpassword = db.prefs.getStringList(db.passwordkey);
    // db.kemail = db.prefs.getStringList(db.emailkey);
    //   db.kusername.add(username_controller.text.toString());
    //   db.kpassword.add(password_controller.text.toString());
    //   await db.prefs.setStringList(db.userskey, db.kusername);
    //   await db.prefs.setStringList(db.passwordkey, db.kpassword);
    //   await db.prefs.setStringList(db.emailkey, db.kemail);
    // }

    if (db.kusername.contains(u)) {
      int index = db.kusername.indexOf(u);

      if (db.kpassword[index] == p) {
        //all good
        gotohome(u);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: diagonal / 15,
                child: Text(
                  "Incorrect Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.redAccent, fontSize: diagonal / 30),
                ),
              );
            });
      }
    } else {
      Navigator.pushNamed(context, '/signup');

      Timer(Duration(seconds: 1), () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: diagonal / 7.5,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "User Not Found.\nCreate new account or",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.redAccent, fontSize: diagonal / 30),
                    ),
                    RaisedButton(
                      color: Colors.redAccent[100],
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);

                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      "\nagain.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.redAccent, fontSize: diagonal / 30),
                    ),
                  ],
                ),
              );
            });
      });
    }
  }

  void gotohome(String u) async {
    await db.prefs.setString(db.currentuserkey, u);
  }

  @override
  Widget build(BuildContext context) {
    getdata();

    var size = MediaQuery.of(context).size;
    var height = size.height / 100;
    var width = size.width / 100;
    var emaildialogtext = "Enter email";
    diagonal = sqrt(size.height * size.width);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                LoginTop(diagonal: diagonal),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: SignUpTop(diagonal: diagonal),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: LoginScreenWelcomeText(diagonal: diagonal),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: diagonal / 15, vertical: diagonal / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LoginUsernameTextField(
                      username_focusnode: username_focusnode,
                      username_controller: username_controller,
                      diagonal: diagonal),
                  SizedBox(
                    height: diagonal / 30,
                  ),
                  LoginPasswordTextField(
                      password_focusnode: password_focusnode,
                      password_controller: password_controller,
                      diagonal: diagonal),
                  SizedBox(
                    height: diagonal / 25,
                  ),
                  ForgotPassword(context, height, width, emaildialogtext),
                ],
              ),
            ),
            LoginButton()
          ],
        ),
      ],
    );
  }

  Expanded LoginButton() {
    return Expanded(
      child: Center(
        child: Container(
          child: GestureDetector(
            onTap: () {
              validate();
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.redAccent[100],
              child: FaIcon(
                FontAwesomeIcons.arrowRight,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Align ForgotPassword(BuildContext context, double height, double width,
      String emaildialogtext) {
    return Align(
      child: GestureDetector(
        child: Text("Forgot Password"),
        onTap: () {
          showDialog(
            context: context,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                height: height * 30,
                width: width * 85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Reset Password",
                      style: TextStyle(
                          color: Colors.redAccent[200],
                          fontSize: diagonal / 30),
                    ),
                    Divider(),
                    TextField(
                      controller: resetTextController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "$emaildialogtext",
                          border: InputBorder.none),
                    ),
                    Divider(),
                    FlatButton(
                      onPressed: () {
                        if (EmailValidator.validate(
                            resetTextController.text.toString())) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                              duration: Duration(seconds: 2),
                              content: Text(
                                "Password reset Mail Sent",
                                style: TextStyle(color: Colors.redAccent[200]),
                              ),
                            ),
                          );
                        } else {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                              duration: Duration(seconds: 2),
                              content: Text(
                                "Enter valid Email",
                                style: TextStyle(color: Colors.redAccent[200]),
                              ),
                            ),
                          );
                        }
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: FaIcon(
                        FontAwesomeIcons.paperPlane,
                        color: Colors.redAccent[200],
                      ),
                    )
                  ],
                ),
              ),
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
      alignment: Alignment.centerLeft,
    );
  }
}
