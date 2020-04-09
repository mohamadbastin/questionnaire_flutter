import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:questionnaire_flutter/widgets/errorDialog.dart';
import 'package:questionnaire_flutter/widgets/formAspects.dart';

class CreateFormScreen extends StatefulWidget {
  static const routeName = '/createForm';

  @override
  _CreateFormScreenState createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> questionTypes = ["Text", "Choice", "Range"];
  String _questionType = "Text";
  List<dynamic> _questions = [];
  TextEditingController _questionTextController = new TextEditingController();
  TextEditingController _currentChoiceController = new TextEditingController();
  TextEditingController _lowThresholdController = new TextEditingController();
  TextEditingController _highThresholdController = new TextEditingController();
  bool _scrollParent = false;
  final _choiceFocusNode = new FocusNode();
  ScrollController controller;
  List<Map<String, dynamic>> _choices = [];
  bool _multiChoice = false;
  final appBar = AppBar(
    elevation: 5,
    title: Text("Create Form"),
    centerTitle: true,
  );
  final listViewScrollController = new ScrollController();

  _createQuestion() {
    if (!_formKey.currentState.validate()) {
      print("val");
      return;
    } else if (_questionType == "Choice") {
      if (_currentChoiceController.text.isNotEmpty) {
        _choices.add({
          "text": _questionTextController.text,
          "controller": _currentChoiceController
        });
      }
      if (_choices.isEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(message: "Choice Questions Must Have At Least One Choice", ctx: context);
          }
        );
      }
    }
    Map<String, dynamic> _currentQuestion = {
      "text": "",
      "type": _questionType,
    };
    _currentQuestion["text"] = _questionTextController.text;
    if (_questionType == "Choice") {
      _currentQuestion["choices"] = _choices;
      _currentQuestion["choice_type"] = (_multiChoice) ? "MA" : "SA";
    } else if (_questionType == "Range") {
      _currentQuestion["start_text"] = _lowThresholdController.text;
      _currentQuestion["end_text"] = _highThresholdController.text;
    }
    setState(() {
      _choices = [];
      _questionTextController.text = "";
      _lowThresholdController.text = "";
      _highThresholdController.text = "";
    });
    _currentChoiceController = new TextEditingController();
    _questions.add(_currentQuestion);
    print(_questions);
  }

  _addChoice() {
    String choice = _currentChoiceController.text;
    if (choice == null || choice.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(message: "Please Fill the Current Choice", ctx: context);
        }
      );
      return;
    }
    setState(() {
      _choices.add({
        "text": choice,
        "controller": _currentChoiceController
      });
      _currentChoiceController = new TextEditingController();
    });
    print(_choices);
    FocusScope.of(context).requestFocus(_choiceFocusNode);

  }

//  _validateQuestion(Map<String, dynamic> question) {
//    if (_questionType == )
//  }

  _removeChoice(choice) {
    choice["controller"].dispose();
    setState(() {
      _choices.remove(choice);
    });
  }

  _setFormAspects(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 10,
        context: context,
        builder: (context) => GestureDetector(
              onDoubleTap: () {
                Navigator.of(context).pop();
              },
              behavior: HitTestBehavior.opaque,
              child: FormAspects(),
            ));
  }

  _scrollToBottom() {
    listViewScrollController.animateTo(
        listViewScrollController.position.maxScrollExtent * 2,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut);
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
          height: mediaSize.height -
              padding.top -
              padding.bottom -
              appBar.preferredSize.height,
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
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  width: mediaSize.width * 0.95,
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
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Container(
                          height: 200,
                          child: IgnorePointer(
                            ignoring: _scrollParent,
                            child: NotificationListener<OverscrollNotification>(
                              onNotification: (_) {

                                setState(() {
                                  _scrollParent = true;
                                });

                                Timer(Duration(seconds: 2), () {
                                  setState(() {
                                    _scrollParent = false;
                                  });
                                });

                                return false;
                              },
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                              prefixIcon: Icon(FontAwesomeIcons.question, color: Colors.white70,),
                                              labelText: "Type Your Question Here",
                                              labelStyle: TextStyle(color: Colors.white70)
                                          ),
                                          maxLines: 3,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        _questionType == "Choice" ? Container(
                                          margin: EdgeInsets.only(left: 20.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text("Multi Choice"),
                                              Switch(
                                                value: _multiChoice,
                                                activeColor: Colors.green,
                                                inactiveThumbColor: Colors.grey,
                                                inactiveTrackColor: Colors.grey,
                                                onChanged: (type) {
                                                  setState(() {
                                                    _multiChoice = type;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ) : Container(),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 15.0),
                                          child: (_questionType == "Choice")
                                              ? ListView(
                                            controller: listViewScrollController,
                                            addAutomaticKeepAlives: true,
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            children: _choices
                                                .map<Widget>((choice) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 3.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: TextFormField(
//                                              enabled: false,
                                                      controller: choice["controller"],
                                                        decoration: InputDecoration(
//                                                hintText: choice["text"],
                                                          prefixIcon: Icon(Icons
                                                              .question_answer),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(left: 5.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle
                                                      ),
                                                      child: IconButton(
                                                        tooltip: "Remove Choice",
                                                        icon: Icon(Icons.delete, color: Colors.white70,),
                                                        onPressed: () {
                                                          _removeChoice(choice);
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }).toList(growable: true) +
                                                [
                                                  TextFormField(
                                                    controller:
                                                    _currentChoiceController,
                                                    focusNode: _choiceFocusNode,
                                                    decoration: InputDecoration(
                                                      hintText: "Question Choice",
                                                      prefixIcon: Icon(
                                                          Icons.question_answer),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    margin:
                                                    EdgeInsets.only(top: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        FloatingActionButton(
                                                          materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                          tooltip:
                                                          "Add Current Choice",
                                                          elevation: 5,
                                                          child: Icon(Icons.add),
                                                          backgroundColor:
                                                          Colors.blue,
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
                                          ) : (_questionType == "Range") ?
                                          ListView(
                                            shrinkWrap: true,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(bottom: 3.0),
                                                child: TextFormField(
                                                  controller: _lowThresholdController,
                                                  validator: (String value) {
                                                    if (value.isEmpty || value == null) {
                                                      return 'This Field is Required';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(Icons.arrow_downward),
                                                    hintText: "Low Threshold",
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(bottom: 3.0),
                                                child: TextFormField(
                                                  controller: _highThresholdController,
                                                  validator: (String value) {
                                                    if (value.isEmpty || value == null) {
                                                      return 'This Field is Required';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(Icons.arrow_upward),
                                                    hintText: "High Threshold",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                              : Container(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FloatingActionButton(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    elevation: 5,
                                    child: Icon(Icons.remove_red_eye),
                                    tooltip: "See Already Created Questions",
                                    backgroundColor: Colors.blueGrey,
                                    heroTag: "visit",
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Recently Created Questions",
                                              textAlign: TextAlign.center,
                                            ),
                                            actions: <Widget>[
                                              RaisedButton(
                                                child: Text(
                                                  "Close",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.white70),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                            content: Container(
                                              width: double.infinity,
                                              child: _questions.isNotEmpty ? ListView.builder(
                                                itemBuilder: (context, index) => Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    (_questions[index]["type"] == "Text") ? Container(
                                                      margin: EdgeInsets.only(bottom: 10.0),
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            flex: 5,
                                                            child: Container(alignment: Alignment.centerLeft, child: Text('${index + 1}. ${_questions[index]["text"]}')),
                                                          ),
                                                          Flexible(
                                                            flex: 1,
                                                            fit: FlexFit.tight,
                                                            child: Container(
                                                                alignment: Alignment.bottomRight,
                                                                child: Text(_questions[index]["type"], style: TextStyle(fontSize: 15.0, color: Colors.blue),)
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ) :
                                                        ExpansionTile(
//                                                          leading: Text('${index + 1}. ${_questions[index]["text"]}', overflow: TextOverflow.fade,),
                                                          title: _questions[index]["type"] == "Choice" ? Text("${_questions[index]["type"]}/${_questions[index]["choice_type"]}", overflow: TextOverflow.fade,) : Text(_questions[index]["type"], overflow: TextOverflow.fade,),
                                                          children: _questions[index]["type"] == "Choice" ? _questions[index]["choices"].map<Widget>((choice) {
                                                            return Text('${_questions[index]["choices"].indexOf(choice) + 1}. ${choice["controller"].text}');
                                                          }).toList() : [
                                                            Text('Low Threshold: ${_questions[index]["start_text"]}'),
                                                            Text('High Threshold: ${_questions[index]["end_text"]}'),
                                                          ],
                                                        )
                                                  ],
                                                ),
                                                itemCount: _questions.length,
                                              ) : Container(),
                                            ),
                                          );
                                        }
                                      );
                                    },
                                  ),
                                  FloatingActionButton(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
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
                            topRight: Radius.elliptical(100, 20))),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {
                      _setFormAspects(context);
                    },
                    child: Text(
                      "Set Form Aspects",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
