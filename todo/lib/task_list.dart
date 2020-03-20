import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/singleton.dart';
import 'package:todo/task_item.dart';

import 'model/task.dart';
import 'model/task_repository.dart';

class TaskList extends StatefulWidget {
  TaskList({Key key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TaskRepository taskRepository = Singleton.taskRepository;
  String _editText = "";

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = taskRepository.getAll();
    return Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_drop_down),
          onPressed: () {
            setState(() {
              for (Task task in tasks) {
                task.checked = true;
                taskRepository.update(task);
              }
            });
          },
        ),
        Expanded(child: TextField(
          onChanged: (String text) {
            _editText = text;
          },
        )),
        IconButton(icon: Icon(Icons.add), onPressed: () {
          setState(() {
            Task task = Task(taskRepository.createNewId(), false, _editText);
            taskRepository.insert(task);
          });
        },),
      ]),
      Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(child: TaskItem(task: tasks[index]));
              }))
    ]);
  }
}
