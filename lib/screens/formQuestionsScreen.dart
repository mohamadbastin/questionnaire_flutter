import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questionnaire_flutter/providers/formProvider.dart';


class FormQuestionsScreen extends StatelessWidget {
  static const routeName = "/formQuestions";

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    final formId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("Form Quetions"), centerTitle: true, elevation: 5.0,),
      body: FutureBuilder(
        future: formProvider.fetchFormQuestions(formId),
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? Center(
          child: CircularProgressIndicator(),
        ) : Center(
          child: Text("hello"),
        ),
      ),
    );
  }
}
