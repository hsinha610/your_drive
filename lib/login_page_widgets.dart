import 'package:flutter/material.dart';

class LoginPasswordTextField extends StatelessWidget {
  LoginPasswordTextField({
    Key key,
    @required this.password_focusnode,
    @required this.password_controller,
    @required this.diagonal,
  }) : super(key: key);

  final FocusNode password_focusnode;
  final TextEditingController password_controller;
  var diagonal;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: password_focusnode,
      controller: password_controller,
      expands: false,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter Password",
        hintStyle: TextStyle(),
        labelText: "Password",
        labelStyle:
            TextStyle(color: Colors.redAccent[200], fontSize: diagonal / 30),
      ),
    );
  }
}

class LoginUsernameTextField extends StatelessWidget {
  LoginUsernameTextField({
    Key key,
    @required this.username_focusnode,
    @required this.username_controller,
    @required this.diagonal,
  }) : super(key: key);

  final FocusNode username_focusnode;
  final TextEditingController username_controller;
  var diagonal;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: username_focusnode,
      controller: username_controller,
      expands: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter Username",
        hintStyle: TextStyle(),
        labelText: "Username",
        labelStyle:
            TextStyle(color: Colors.redAccent[200], fontSize: diagonal / 30),
      ),
    );
  }
}

class LoginScreenWelcomeText extends StatelessWidget {
  LoginScreenWelcomeText({
    Key key,
    @required this.diagonal,
  }) : super(key: key);

  var diagonal;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Welcome To,\n",
        style: TextStyle(fontSize: diagonal / 25, color: Colors.black),
        children: [
          TextSpan(
            text: "Your Drive",
            style: TextStyle(
                fontSize: diagonal / 12,
                color: Colors.redAccent[200],
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class SignUpTop extends StatelessWidget {
  SignUpTop({
    Key key,
    @required this.diagonal,
  }) : super(key: key);

  var diagonal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(diagonal / 40, diagonal / 20, diagonal / 20, 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white, width: diagonal / 300),
        ),
      ),
      padding: EdgeInsets.all(diagonal / 40),
      child: Text(
        "Sign Up",
        style: TextStyle(fontSize: diagonal / 30),
      ),
    );
  }
}

class LoginTop extends StatelessWidget {
  LoginTop({
    Key key,
    @required this.diagonal,
  }) : super(key: key);

  var diagonal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(diagonal / 20, diagonal / 20, diagonal / 40, 0),
      decoration: BoxDecoration(
        border: Border(
          bottom:
              BorderSide(color: Colors.redAccent[200], width: diagonal / 300),
        ),
      ),
      padding: EdgeInsets.all(diagonal / 40),
      child: Text(
        "Login",
        style: TextStyle(fontSize: diagonal / 30),
      ),
    );
  }
}
