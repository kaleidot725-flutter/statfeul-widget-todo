import 'package:flutter/material.dart';
import 'package:todo/model/task.dart';

class TodoPage extends StatefulWidget {
  TodoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final String title = "TODOS";
  final List<Task> tasks = <Task>[
    Task(true, "A"),
    Task(false, "B"),
    Task(true, "C"),
    Task(true, "D"),
    Task(false, "E"),
    Task(true, "F"),
    Task(false, "G"),
    Task(true, "H"),
    Task(false, "I"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("title")),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              createTaskTextField(),
              Expanded(child: createTaskListView())
            ],
          ),
      ),
    );
  }

  TextField createTaskTextField() {
    return TextField();
  }

  ListView createTaskListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: Row(children: <Widget>[
                Checkbox(value: tasks[index].checked),
                Text(tasks[index].name),
              ])
          );
        }
    );
  }
}
