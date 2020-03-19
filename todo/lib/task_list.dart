
import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = taskRepository.getAll();
    return Expanded(child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(child: TaskItem(task: tasks[index]));
        }
    ));
  }
}