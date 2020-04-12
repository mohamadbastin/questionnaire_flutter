import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:questionnaire_flutter/providers/formProvider.dart';

class FormQuestionsScreen extends StatefulWidget {
  static const routeName = "/formQuestions";
  final int formId;


  FormQuestionsScreen(this.formId);

  @override
  _FormQuestionsScreenState createState() => _FormQuestionsScreenState();
}

class _FormQuestionsScreenState extends State<FormQuestionsScreen> {

  var formProvider;
  Future<void> _future;
  var formId;

  @override
  void initState() {
    // TODO: implement initState
    formProvider = Provider.of<FormProvider>(context, listen: false);
    print("formId: " + widget.formId.toString());
    _future = Provider.of<FormProvider>(context, listen: false).fetchFormQuestions(widget.formId);
    print("init state");
    print(formQuestions);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final f = Provider.of<FormProvider>(context, listen: false);
    formId = ModalRoute.of(context).settings.arguments;
    return FutureBuilder(
        future: _future,
        builder: (_, snapshot) => RefreshIndicator(
          onRefresh: () => f.fetchFormQuestions(widget.formId),
          child: snapshot.connectionState == ConnectionState.waiting
              ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
              : FormQuestions(),
        )
    );
  }
}


class FormQuestions extends StatefulWidget {

  @override
  _FormQuestionsState createState() => _FormQuestionsState();
}

class _FormQuestionsState extends State<FormQuestions> {
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  UniqueKey key = UniqueKey();

  double _value = 0.0;
  TextEditingController _txt = new TextEditingController();
  List<Map<String, dynamic>> _formAnswers = [];
  
  @override
  void initState() {
    // TODO: implement initState
    formQuestions.forEach((formQuestion) {
      if (formQuestion["question"]["type"] == "text" || formQuestion["question"]["type"] == "range") {
        _formAnswers.add({
          "answer": new TextEditingController()
        });
      } else if (formQuestion["question"]["type"] == "choice") {
        var selectedChoice = [];
        formQuestion["question"]["choice"].forEach((choice) {
          selectedChoice.add(false);
        });
        _formAnswers.add({
          "answer": selectedChoice
        });
      }
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Form Questions"), centerTitle: true, elevation: 5.0,),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: ListView.builder(
                  itemBuilder: (context, index) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                              colors: [
                                hexToColor('#d7d2cc'),
                                hexToColor('#304352'),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                          )
                      ),

                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        key: key,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                                '${index + 1}. ${formQuestions[index]["question"]["text"]}',
                              style: TextStyle(
                                fontSize: 16.0
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          Container(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: formQuestions[index]["question"]["type"] == "text" ? TextFormField(
                              controller: _formAnswers[index]["answer"],
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.question_answer, color: Colors.white70,),
                                  labelText: "Type Your Answer Here",
                                  labelStyle: TextStyle(color: Colors.white70)
                              ),
                              maxLines: 3,
                            ) : (formQuestions[index]["question"]["type"] == "choice") ? ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, choiceIndex) => CheckboxListTile(
                                value: false,
                                title: Text(
                                    '${formQuestions[index]["question"]["choice"][choiceIndex]["text"]}'
                                ),
                                onChanged: (value) {

                                },
                              ),
                              itemCount: formQuestions[index]["question"]["choice"].length,
                            ) : Slider(
                              value: _value,
                              min: 0,
                              max: 100,
                              divisions: 10,
                              label: '$_value',
                              onChanged: (value) {
                                setState(
                                      () {
                                    _value = value;
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: formQuestions.length,
                ),
              ),
            ),

            Container(
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(100, 20),
                        topRight: Radius.elliptical(100, 20))),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  child: Text(
                    "Submit Answers",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
