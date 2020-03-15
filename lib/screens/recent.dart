import 'package:flutter/material.dart';


class RecentFormsScreen extends StatefulWidget {
  static final routeName = "/recent";
  @override
  _RecentFormsScreenState createState() => _RecentFormsScreenState();
}

class _RecentFormsScreenState extends State<RecentFormsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.yellow,
        child: Center(child: Text("wxjbenxvjn"),),
      ),
      
    );
  }
}