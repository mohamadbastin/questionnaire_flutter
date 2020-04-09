import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questionnaire_flutter/models/profile.dart';
import 'package:questionnaire_flutter/widgets/settings.dart';

class MainDrawer extends StatelessWidget {
  Widget _drawerListTile(String title, String routeName, BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        // Provider.of<Profile>(context, listen: false).logout();
        Navigator.of(context).popAndPushNamed(routeName);
      },
    );
  }

  Widget _drawerListTileLogOut(String title, String routeName, BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Provider.of<Profile>(context, listen: false).logout();
        Navigator.of(context).popAndPushNamed(routeName);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text("AskFill"),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.settings),
                onPressed: null
              ),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.notifications), onPressed: null)
              ],
            ),
            GestureDetector(
                onTap: null,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.grey,
                      Colors.blueGrey,
                    ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(100, 50),
                      bottomLeft: Radius.elliptical(100, 50),
                    )
                  ),
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
                        decoration: BoxDecoration(shape: BoxShape.circle),
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
                      Container(alignment: Alignment.center,)
                    ],
                  ),
                ))),
            _drawerListTile('Home', '/recent', context),
            Divider(),
            _drawerListTile('Filled Forms', '/auth', context),
            Divider(),
            _drawerListTile("Create Form", '/createForm', context),
            Divider(),
            _drawerListTileLogOut("Logout", '/auth', context),

          ],
        ),
      ),
    );
  }
}
