import 'package:flutter/material.dart';
import 'package:questionnaire_flutter/models/form.dart';
import 'package:intl/intl.dart' as intl;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:questionnaire_flutter/screens/formQuestionsScreen.dart';
import 'package:questionnaire_flutter/widgets/drawer.dart';

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
        appBar: AppBar(title: Text(form.name), centerTitle: true, elevation: 5.0,),
        drawer: MainDrawer(),
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
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
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Container(
                                    // color:Colors.red,
                                    padding: EdgeInsets.only(top: 30),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                SizedBox(height: 10.0,),
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

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
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
                                                SizedBox(height: 10.0,),
                                                Row(
                                                  children: <Widget>[
                                                    // Padding(padding: EdgeInsets.only(left:45),),
                                                    Icon(Icons.loop),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Container(
                                                        child: Text(
                                                            '${form.duration.toString()} Day(s)'
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10.0,),
                                        Divider(
                                          height: 1,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
//                                              Icon(
//                                                Icons.description,
//                                                color: Colors.black,
//                                              ),
                                              Expanded(
                                                child: Container(
                                                  child:
                                                  Directionality(
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
                                              )
                                            ]),
                                        SizedBox(height: 20.0,),
                                        form.is_private == true
                                            ? TextFormField(
                                            controller: pass,
                                            decoration:
                                            InputDecoration(
                                                prefixIcon: Icon(Icons.lock_outline),
                                                hintText:
                                                "password"))
                                            : Container(),
                                        SizedBox(height: 30.0,),
                                        Container(
                                          width: double.infinity,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.elliptical(100, 70),
                                                topLeft: Radius.elliptical(100, 70),
                                              )
                                            ),
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                  FormQuestionsScreen.routeName,
                                                  arguments: form.id
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                                child: Text('Participate'),
                                              )),
                                        )
                                      ],
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
        ),
    );
  }
}
