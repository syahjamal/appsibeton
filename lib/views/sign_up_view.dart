import 'package:flutter/material.dart';
import 'package:appsibeton/services/auth_service.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[800],
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
          child: Column(
        children: <Widget>[Text("SignUp")],
      )),
    );
  }
}
