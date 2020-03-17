import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questionnaire_flutter/models/profile.dart';


class AuthScreen extends StatefulWidget {
  static final routeName = "/auth";
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController phoneController = new TextEditingController();
  var focusNode = new FocusNode();
  String that = "next";
  Future<void> _sendcode;

  validatephone() async {
    // phoneController.
    if (that == "next") {
      setState(() {
        that = "";
        FocusScope.of(context).requestFocus(new FocusNode());
      });
      if (phoneController.text.length == 10 && phoneController.text[0] == "9"){
            _sendcode = Provider.of<Profile>(context, listen: false).sendCode(phoneController.text);
            

      } else {
        showDialog(
                
                context: context,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(0.0),
                    titlePadding: EdgeInsets.all(0.0),
                    content: Container(
                      color: Colors.redAccent,
                      child: Column(children: <Widget>[Center(child: Text("Phone Number Is Not Valid.\nTry Again")),
                      Align(alignment: Alignment.bottomCenter,child: RaisedButton(onPressed: null, child: Text("ok"),))]),
                      height: 100,
                      width: 100,
                    )
                  );
                });        
      }
    } else {
      setState(() {
        that = "next";
        FocusScope.of(context).requestFocus(focusNode);
      });
    }
  }


  enabletext() {
    if (that=="next"){
      return true;
    } else {
      return false;
    }
  }


  @override
  void initState (){
    super.initState();



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          that == "next"
              ? InkWell(
                  child: Container(
                    child: Center(
                      child: Text("Next"),
                    ),
                  ),
                  onTap: validatephone)
              : InkWell(
                  child: CircularProgressIndicator(),
                  onTap: validatephone,
                ),
        ],
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      resizeToAvoidBottomPadding: true,
      body: new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          child: Center(
            child: Column(children: <Widget>[
              Expanded(
                flex: 1,
                child: SizedBox(height: 100),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.asset('assets/images/frm.png'),
                    width: 200,
                  )),
              Expanded(
                flex: 1,
                child: SizedBox(height: 100),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment(0, -0.8),
                    child: Text(
                      "AskFill Login",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(height: 20),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    // foregroundDecoration: BoxDecoration(
                    //   color: Colors.grey,
                    //   backgroundBlendMode: BlendMode.clear,
                    // ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        focusNode: focusNode,
                        autofocus: true,
                        // readOnly: that=="next"? false : true,
                        // enabled: that=="next"? false : true,
                        enabled: true,
                        // enabled: enabletext() ,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          // labelText: 'Enter Your Phone Number',
                          // enabledBorder: UnderlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.black, width: 0.0)),
                          // hintText: 'Enter Your Phone Number',
                          prefix: Text('+98'),
                          hintStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.black,
                        )),
                  ),
              ),
              Expanded(flex: 2, child: Container()),
            ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: null),
    );
  }
}
