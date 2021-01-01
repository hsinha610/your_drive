import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart';
import 'sign_up_page_widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: device.orientation == Orientation.portrait
            ? SignUpPage1()
            : Container(),
      ),
    );
  }
}

class SignUpPage1 extends StatefulWidget {
  @override
  _SignUpPage1State createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1> {
  TextEditingController username_controller;
  TextEditingController email_controller;
  TextEditingController password_controller;
  FocusNode username_focusnode;
  FocusNode email_focusnode;
  FocusNode password_focusnode;
  @override
  void initState() {
    username_controller = TextEditingController();
    email_controller = TextEditingController();
    password_controller = TextEditingController();
    username_focusnode = FocusNode();
    email_focusnode = FocusNode();
    password_focusnode = FocusNode();
    super.initState();
    getdata();
  }

  @override
  void dispose() {
    username_controller.dispose();
    email_controller.dispose();
    password_controller.dispose();
    username_focusnode.dispose();
    email_focusnode.dispose();
    password_focusnode.dispose();
    super.dispose();
  }

  var diagonal;

  void validate() {
    String u = username_controller.text.toString();
    String p = password_controller.text.toString();
    String e = email_controller.text.toString();

    if (u.isEmpty || p.isEmpty || e.isEmpty) {
      String msg = "";
      if (u.isEmpty) msg += " username,";
      if (e.isEmpty) msg += " email,";
      if (p.isEmpty) msg += " password,";
      msg = "Enter " + msg.substring(0, msg.length - 1);

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
      if (!EmailValidator.validate(e)) {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: diagonal / 15,
                child: Text(
                  "Enter valid Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.redAccent, fontSize: diagonal / 30),
                ),
              );
            });
      } else if (db.kusername.contains(username_controller.text.toString())) {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: diagonal / 15,
                child: Text(
                  "Username already taken",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.redAccent, fontSize: diagonal / 30),
                ),
              );
            });
      } else if (db.kemail.contains(email_controller.text.toString())) {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: diagonal / 15,
                child: Text(
                  "Email already registered",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.redAccent, fontSize: diagonal / 30),
                ),
              );
            });
      } else {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return FutureBuilder(
                builder: (context, snap) {
                  if (snap.connectionState != ConnectionState.done) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      height: diagonal / 15,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.redAccent[200],
                      ),
                    );
                  }

                  return Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    height: diagonal / 7.5,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Sign Up Successful.\nLogin to continue.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.redAccent, fontSize: diagonal / 30),
                        ),
                        RaisedButton(
                          color: Colors.redAccent[100],
                          child: Text("Login"),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  );
                },
                future: save(),
              );
            });
      }
    }
  }

  Database db = Database();

  void getdata() async {
    db.prefs = await SharedPreferences.getInstance();

    db.kusername = db.prefs.getStringList(db.userskey);
    db.kpassword = db.prefs.getStringList(db.passwordkey);
    db.kemail = db.prefs.getStringList(db.emailkey);
  }

  Future<void> save() async {
    db.kusername.add(username_controller.text.toString());
    db.kemail.add(email_controller.text.toString());
    db.kpassword.add(password_controller.text.toString());
    await db.prefs.setStringList(db.userskey, db.kusername);
    await db.prefs.setStringList(db.passwordkey, db.kpassword);
    await db.prefs.setStringList(db.emailkey, db.kemail);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    diagonal = sqrt(size.height * size.width);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SignUpTopRow(diagonal: diagonal),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: SignUpWelcomeText(diagonal: diagonal),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: diagonal / 15, vertical: diagonal / 15),
              child: SignUpInput(
                  username_focusnode: username_focusnode,
                  username_controller: username_controller,
                  diagonal: diagonal,
                  email_focusnode: email_focusnode,
                  email_controller: email_controller,
                  password_focusnode: password_focusnode,
                  password_controller: password_controller),
            ),
            SignUpButtonBottom(),
          ],
        ),
      ],
    );
  }

  Expanded SignUpButtonBottom() {
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
}
