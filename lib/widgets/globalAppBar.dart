import 'package:flutter/material.dart';
import 'package:questionnaire_flutter/widgets/settings.dart';

class GlobalAppBar extends StatefulWidget implements PreferredSizeWidget {

  @override
  final Size preferredSize;

  GlobalAppBar({Key key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  _GlobalAppBarState createState() => _GlobalAppBarState();
}

class _GlobalAppBarState extends State<GlobalAppBar> {
  _openSettingsModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 10,
        context: context,
        builder: (context) => GestureDetector(
          onDoubleTap: () {
            Navigator.of(context).pop();
          },
          behavior: HitTestBehavior.opaque,
          child: Settings(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      title: Text("Create Form"),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            _openSettingsModal();
          },
        )
      ],
    );
  }
}
