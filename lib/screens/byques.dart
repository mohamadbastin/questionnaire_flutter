import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questionnaire_flutter/models/form.dart';
import 'package:questionnaire_flutter/providers/formProvider.dart';

class ChooseQuesScreen extends StatelessWidget {
  static final String routeName = '/byques';
  @override
  Widget build(BuildContext context) {
    final myForm form = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("Choose Question"),),
      body: FutureBuilder(
        future: Provider.of<FormProvider>(context, listen: false).fetchFormQuestions(form.id),
            
        builder: (_, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )
            : Container()
            // FormQuestions()
            )
      
    );
  }
}