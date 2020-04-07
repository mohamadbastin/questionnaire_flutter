import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateFormScreen extends StatefulWidget {
  static const routeName = '/createForm';
  @override
  _CreateFormScreenState createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> questionTypes = ["Text", "Choice"];
  String _questionType = "Text";
  List<dynamic> _questions = [];
  TextEditingController _questionTextController = new TextEditingController();
  TextEditingController _currentChoiceController = new TextEditingController();
  List<String> _choices = [];

  final appBar = AppBar(
    elevation: 5,
    title: Text("Create Form"),
    centerTitle: true,
  );
  final listViewScrollController = new ScrollController();
  void _createQuestion() {
    Map<String, dynamic> _currentQuestion = {
      "text": "",
    };
    _currentQuestion["text"] = _questionTextController.text;
    if (_questionType == "Choice") {
      _currentQuestion["choices"] = _choices;
      _choices = [];
    }
    _questions.add(_currentQuestion);
    _questionTextController.text = "";
    print(_questions);
  }

  _addChoice() {
    String choice = _currentChoiceController.text;
    setState(() {
      _choices.add(choice);
      _currentChoiceController.text = "";
    });
    print(_choices);
  }

  _scrollToBottom() {
    listViewScrollController.animateTo(listViewScrollController.position.maxScrollExtent * 2,
        duration: Duration(milliseconds: 200), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: mediaSize.width,
          height: mediaSize.height - padding.top - padding.bottom - appBar.preferredSize.height,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: mediaSize.width * 0.8,
                  child: DropdownButton<String>(
                    value: _questionType,
                    isExpanded: true,
                    hint: Text("Choose"),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        _questionType = newValue;
                      });
                    },
                    items: questionTypes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                        .toList(),
                  ),
                ),
              ),


              Expanded(
                flex: 7,
                child: Container(
                  width: mediaSize.width * 0.9,
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(3.0, 10.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              TextFormField(
                                controller: _questionTextController,
                                validator: (String value) {
                                  if (value.isEmpty || value == null) {
                                    return 'This Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(FontAwesomeIcons.question),
                                    hintText: "Type Your Question Here",
                                ),
                              ),
                              SizedBox(height: 10.0,),
                          Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.only(left: 15.0),
                              child: (_questionType == "Choice") ? ListView(
                                controller: listViewScrollController,
                                addAutomaticKeepAlives: true,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                children: _choices.map<Widget>((String choice) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 3.0),
                                    child: TextFormField(
                                      enabled: false,
                                      validator: (String value) {
                                        if (value.isEmpty || value == null) {
                                          return 'This Field is Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: choice,
                                        prefixIcon: Icon(Icons.question_answer),
                                      ),
                                    ),
                                  );
                                }).toList(growable: true) + [
                                  TextFormField(
                                    controller: _currentChoiceController,
                                    validator: (String value) {
                                      if (value.isEmpty || value == null) {
                                        return 'This Field is Required';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Question Choice",
                                      prefixIcon: Icon(Icons.question_answer),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        FloatingActionButton(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          tooltip: "Add Current Choice",
                                          elevation: 5,
                                          child: Icon(Icons.add),
                                          backgroundColor: Colors.redAccent,
                                          heroTag: "choice",
                                          onPressed: () {
                                            setState(() {
                                              _addChoice();
                                              print("here");
                                              _scrollToBottom();
                                            });

                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ) : Container(),
                            ),
                          ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FloatingActionButton(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    elevation: 5,
                                    child: Icon(Icons.remove_red_eye),
                                    tooltip: "See Already Created Questions",
                                    backgroundColor: Colors.blueGrey,
                                    heroTag: "visit",
                                    onPressed: () {
                                    },
                                  ),
                                  FloatingActionButton(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    tooltip: "Create Question",
                                    elevation: 5,
                                    child: Icon(Icons.add),
                                    backgroundColor: Colors.redAccent,
                                    heroTag: "create",
                                    onPressed: () {
                                      _createQuestion();
                                    },
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),



              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(100, 20),
                        topRight: Radius.elliptical(100, 20)
                      )
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {

                    },
                    child: Text("Create Form", style: TextStyle(fontSize: 18.0),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
