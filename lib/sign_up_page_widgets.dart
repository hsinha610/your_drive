import 'package:flutter/material.dart';

class SignUpInput extends StatelessWidget {
  SignUpInput({
    Key key,
    @required this.username_focusnode,
    @required this.username_controller,
    @required this.diagonal,
    @required this.email_focusnode,
    @required this.email_controller,
    @required this.password_focusnode,
    @required this.password_controller,
  }) : super(key: key);

  final FocusNode username_focusnode;
  final TextEditingController username_controller;
  var diagonal;
  final FocusNode email_focusnode;
  final TextEditingController email_controller;
  final FocusNode password_focusnode;
  final TextEditingController password_controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextField(
          focusNode: username_focusnode,
          controller: username_controller,
          keyboardType: TextInputType.text,
          expands: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter Username",
            hintStyle: TextStyle(),
            labelText: "Username",
            labelStyle: TextStyle(
                color: Colors.redAccent[200], fontSize: diagonal / 30),
          ),
        ),
        SizedBox(
          height: diagonal / 30,
        ),
        TextField(
          focusNode: email_focusnode,
          controller: email_controller,
          keyboardType: TextInputType.emailAddress,
          expands: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter email",
            hintStyle: TextStyle(),
            labelText: "Email Id",
            labelStyle: TextStyle(
                color: Colors.redAccent[200], fontSize: diagonal / 30),
          ),
        ),
        SizedBox(
          height: diagonal / 30,
        ),
        TextField(
          focusNode: password_focusnode,
          controller: password_controller,
          expands: false,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter Password",
            hintStyle: TextStyle(),
            labelText: "Password",
            labelStyle: TextStyle(
                color: Colors.redAccent[200], fontSize: diagonal / 30),
          ),
        ),
        SizedBox(
          height: diagonal / 50,
        ),
      ],
    );
  }
}

class SignUpWelcomeText extends StatelessWidget {
  SignUpWelcomeText({
    Key key,
    @required this.diagonal,
  }) : super(key: key);

  var diagonal;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Hey There!\n",
        style: TextStyle(
            fontSize: diagonal / 12,
            color: Colors.redAccent[200],
            fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "Enter your details below.",
            style: TextStyle(
                fontSize: diagonal / 25,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class SignUpTopRow extends StatelessWidget {
  SignUpTopRow({
    Key key,
    @required this.diagonal,
  }) : super(key: key);

  var diagonal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(
                diagonal / 20, diagonal / 20, diagonal / 40, 0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: diagonal / 300),
              ),
            ),
            padding: EdgeInsets.all(diagonal / 40),
            child: Text(
              "Login",
              style: TextStyle(fontSize: diagonal / 30),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              diagonal / 40, diagonal / 20, diagonal / 20, 0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Colors.redAccent[200], width: diagonal / 300),
            ),
          ),
          padding: EdgeInsets.all(diagonal / 40),
          child: Text(
            "Sign Up",
            style: TextStyle(fontSize: diagonal / 30),
          ),
        ),
      ],
    );
  }
}
