import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blueAccent,
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.blueAccent,
              title: Text("AskFill"),
              leading: IconButton(
                icon: Icon(Icons.settings),
                onPressed: null,
              ),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.notifications), onPressed: null)
              ],
            ),
            GestureDetector(
                onTap: null,
                child: DrawerHeader(
                    child: Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      
                      Container(
                        // alignment: Alignment.centerLeft,
                        height: 100,
                        width: 100,
                        // margin: EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: ClipOval(
                            child: FadeInImage(
                              placeholder: AssetImage(
                                'assets/images/a.png',
                              ),
                              image:  AssetImage(
                                      'assets/images/a.png',
                                    )
                                  
                                    
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))),
            // Divider(),
            ListTile(title: Text("My Forms"), onTap: null),
            Divider(),
            ListTile(
              title: Text('Filled Forms'),
              onTap: null,
            ),
            Divider(),
            ListTile(
              title: Text('Log Out'),
            )
          ],
        ),
      ),
    );
  }
}
