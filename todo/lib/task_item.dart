import 'package:flutter/material.dart';
import 'package:todo/model/singleton.dart';
import 'package:todo/model/task.dart';
import 'package:todo/model/task_repository.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  TaskItem({Key key, this.task}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState(task);
}

class _TaskItemState extends State<TaskItem> {
  final TaskRepository repo = Singleton.taskRepository;
  final Task task;

  _TaskItemState(this.task);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: task.checked,
          onChanged: (value) {
            setState(() {
              task.checked = value;
              repo.update(task);
            });
          },
        ),
        Text(task.name)
      ],
    );
  }
}
