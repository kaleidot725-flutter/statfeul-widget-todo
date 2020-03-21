import 'package:flutter/material.dart';
import 'package:todo/task_list.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final String title = "TODO";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        margin: EdgeInsets.all(8),
          child: TaskList()
      ),
    );
  }
}
