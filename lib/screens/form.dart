import 'package:flutter/material.dart';
import 'package:questionnaire_flutter/models/form.dart';

class FormScreen extends StatefulWidget {
  static final routeName = "/form";
  // final myForm form;
  // FormScreen({@required this.form});
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {

  final myForm form = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(form.name)),
      backgroundColor: Colors.grey,
      body: 
        Container(width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: <Widget>[
          Hero(
        tag: form.name+form.author.name,
              child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Image.asset(
                        'assets/images/a.png',
                        fit: BoxFit.cover,
                        height: 150,
                        width: double.infinity,
                      ),

//                  child: Image.network(
//                    meal.imageUrl,
//                    fit: BoxFit.cover,
//                    height: 250,
//                    width: double.infinity,
//                  ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 20,
                      child: Container(
                        color: Colors.black54,
                        height: 40,
                        width: 300,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: Text(
                          form.name,
                          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    )
                  ],
                ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 300,
                  child: SizedBox(height: 300)
                  
                )
              )
            ],
          ),
        ),
      ),
        ],),)
    );
  }
}


