import 'package:flutter/material.dart';
import 'package:todo/widgets/todo_page/todo_page.dart';

import 'singleton.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      home: TodoApp()
    );
  }
}
