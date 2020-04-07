import 'package:flutter/material.dart';
import 'package:questionnaire_flutter/models/form.dart';

class FormScreen extends StatefulWidget {
  static final routeName = "/form";
  myForm form;
  FormScreen({@required this.form});
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {

  final myForm form = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(form.name)),
      backgroundColor: Colors.amberAccent,
      body: Container(child: Center(child: Text(form.name),)),
    );
  }
}


