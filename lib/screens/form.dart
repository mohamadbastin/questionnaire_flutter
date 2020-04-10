import 'package:flutter/material.dart';
import 'package:questionnaire_flutter/models/form.dart';
import 'package:intl/intl.dart' as intl;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormScreen extends StatefulWidget {
  static final routeName = "/form";
  // final myForm form;
  // FormScreen({@required this.form});
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final myForm form = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(title: Text(form.name)),
        backgroundColor: Colors.grey,
        body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
                      child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: form.name + form.author.name,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
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
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
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
                                  // height: 300,
                                  padding: EdgeInsets.only(left: 50, right: 50),
                                  child: Center(
                                    child: Container(
                                      // color:Colors.red,
                                      padding: EdgeInsets.only(top: 30),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Icon(Icons.timer),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Container(
                                                      child: Text(
                                                          '${form.estimated_time.toString()} min'))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Icon(Icons.calendar_today),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        // DateFormat.yMMMEd().format(DateTime.parse(form.created)),
                                                        intl.DateFormat.yMMMMd()
                                                            .format(
                                                                DateTime.parse(
                                                                    form.created))
                                                        // form.created
                                                        ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 20),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              // Padding(padding: EdgeInsets.only(left:45),),
                                              Icon(FontAwesomeIcons.pen),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                  child: Text(form.author.name))
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 50),
                                          ),
                                          Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.description,
                                                  color: Colors.black,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(3),
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.fill,
                                                  child: Container(
                                                    // height: 200,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        158,
                                                    child: Container(
                                                      height: 100,
                                                      child:
                                                          SingleChildScrollView(
                                                        // height: 200,
                                                        child: Directionality(
                                                          // TODO
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          child: Text(
                                                            form.description,
                                                            //  textDirection:,

                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                          Padding(
                                            padding: EdgeInsets.only(top: 50),
                                          ),
                                          form.is_private == true
                                              ? Row(
                                                  children: <Widget>[
                                                    // Icon(Icons.lock_outline),
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(
                                                    //       left: 10),
                                                    // ),
                                                    Align(
                                                      alignment: Alignment.center,
                                                                                                          child: Container(
                                                        // color: Colors.red,
                                                       padding: EdgeInsets.only(
                                                         bottom: MediaQuery.of(
                                                                 context)
                                                             .viewInsets
                                                             .bottom,
                                                       ),
                                                       width: 200,
                                                       child: TextFormField(
                                                           controller: pass,
                                                           decoration:
                                                               InputDecoration(
                                                                 prefixIcon: Icon(Icons.lock_outline),
                                                                   hintText:
                                                                       "password"))),
                                                    )
                                                  ],
                                                )
                                              : Container(),
                                          Padding(
                                            padding: EdgeInsets.only(top: 20),
                                          ),
                                          pass.text.isEmpty
                                              ? RaisedButton(
                                                  onPressed: null,
                                                  child: Text('Participate'))
                                              : RaisedButton(
                                                  onPressed: () {
                                                    print(form.is_private);
                                                  },
                                                  child: Text('Participate')),
                                          SizedBox(
                                            height: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                  )))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
