import 'package:flutter/material.dart';
import 'package:todo/task_list.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo")),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: TaskList()
      ),
    );
  }
}
