import 'package:flutter/material.dart';
import 'package:todo/model/task.dart';
import 'package:todo/task_item.dart';
import 'package:todo/task_list.dart';
import 'model/task_repository.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(),
              TaskList(),
            ],
          ),
      ),
    );
  }
}
