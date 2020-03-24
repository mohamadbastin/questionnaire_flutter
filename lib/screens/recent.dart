import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questionnaire_flutter/models/form.dart';
import 'package:questionnaire_flutter/providers/formProvider.dart';
import 'package:questionnaire_flutter/models/profile.dart';
import 'package:questionnaire_flutter/widgets/drawer.dart';

class RecentFormsScreen extends StatefulWidget {
  static final routeName = "/recent";
  @override
  _RecentFormsScreenState createState() => _RecentFormsScreenState();
}

class _RecentFormsScreenState extends State<RecentFormsScreen> {
  FormProvider _forms;

  @override
  void initState() {
    super.initState();
    _forms = Provider.of<FormProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<FormProvider>(context, listen: false)
            .fetchAndSetmyForms(),
        builder: (_, snapshot) => RefreshIndicator(
              onRefresh: Provider.of<FormProvider>(context, listen: false)
                  .fetchAndSetmyForms,
              child: snapshot.connectionState == ConnectionState.waiting
                  ? Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    )
                  : RecentForms(),
            ));
  }
}

class RecentForms extends StatefulWidget {
  @override
  _RecentFormsState createState() => _RecentFormsState();
}

class _RecentFormsState extends State<RecentForms> {
  List<myForm> ic;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      drawer: MainDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: myFormsList.length,
              itemBuilder: (context, i) {
                // print(i);
                return Column(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 230,
                    child: Stack(children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            // color: Colors.cyanAccent,
                            decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 110,
                            child: Container(
                              // alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 25, left: 15, right: 15, bottom: 15),
                                child: Wrap(
                                    alignment: WrapAlignment.start,
                                    spacing: 20,
                                    runSpacing: 10,
                                    children: <Widget>[
                                      Container(decoration: BoxDecoration(color: Colors.purpleAccent, borderRadius: BorderRadius.circular(5)),padding: EdgeInsets.all(5),child: Text(myFormsList[i].name)),
                                      Container(decoration: BoxDecoration(color: Colors.purpleAccent, borderRadius: BorderRadius.circular(5)),padding: EdgeInsets.all(5),child: Text(myFormsList[i].description)),
                                      Container(decoration: BoxDecoration(color: Colors.purpleAccent, borderRadius: BorderRadius.circular(5)),padding: EdgeInsets.all(5),child: Text(myFormsList[i].author.name)),
                                      Container(decoration: BoxDecoration(color: Colors.purpleAccent, borderRadius: BorderRadius.circular(5)),padding: EdgeInsets.all(5),child: Text(myFormsList[i].estimated_time.toString())),
                                      Container(decoration: BoxDecoration(color: Colors.purpleAccent, borderRadius: BorderRadius.circular(5)),padding: EdgeInsets.all(5),child: Text(myFormsList[i].name)),
                                      Container(decoration: BoxDecoration(color: Colors.purpleAccent, borderRadius: BorderRadius.circular(5)),padding: EdgeInsets.all(5),child: Text(myFormsList[i].name)),
                                      Container(decoration: BoxDecoration(color: Colors.purpleAccent, borderRadius: BorderRadius.circular(5)),padding: EdgeInsets.all(5),child: Text(myFormsList[i].name)),
                                    ]),
                              ),
                            )),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.redAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 140,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ClipRRect(
                            child: Image.asset(
                              'assets/images/a.png',
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Divider()
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
