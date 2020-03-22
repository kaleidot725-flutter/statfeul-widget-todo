import 'package:flutter/material.dart';
import 'package:todo/task_list.dart';

class TodoApp extends StatefulWidget {
  TodoApp({Key key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoApp> {
  final String title = "TODO";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(margin: EdgeInsets.all(8), child: TaskList())
    );
  }
}
