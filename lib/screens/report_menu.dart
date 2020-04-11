import 'package:flutter/material.dart';
import 'package:questionnaire_flutter/models/form.dart';

class ReportMenuScreen extends StatelessWidget {
  static final routeName = "/recent";

  @override
  Widget build(BuildContext context) {
    final myForm form = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Reports')),
      body: ListView(children: [
        ListTile()
      ]),
      
    );
  }
}