import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/singleton.dart';
import 'models/task.dart';
import 'models/task_repository.dart';

class TaskList extends StatefulWidget {
  TaskList({Key key}) : super(key: key);

  @override
  _TaskListState createState() {
    var state = _TaskListState();
    return state;
  }
}

class _TaskListState extends State<TaskList> {
  TaskRepository _repository = Singleton.taskRepository;
  List<Task> _tasks = [];
  String _taskName = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _repository.getAll(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        _tasks = snapshot.data;
        return Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            buildAllCheckButton(),
            buildTaskNameTextField(),
            buildTaskAddButton(),
          ]),
          Expanded(child:buildTaskListView())
        ]);
      },
    );
  }

  Widget buildAllCheckButton() {
    return IconButton(
      icon: Icon(Icons.arrow_drop_down),
      onPressed: () {
        setState(() {
          var nextState = getNextAllCheckedState();
          for (Task task in _tasks) {
            task.checked = nextState;
            _repository.update(task);
          }
        });
      },
    );
  }

  Widget buildTaskNameTextField() {
    return Expanded(child: TextField(
      onChanged: (String text) {
        _taskName = text;
      },
    ));
  }

  Widget buildTaskAddButton() {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        setState(() {
          _repository.insert(Task(_repository.createNewId(), false, _taskName));
        });
      },
    );
  }

  Widget buildTaskListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return buildTaskListItem(_tasks[index]);
        });
  }

  Widget buildTaskListItem(Task task) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: task.checked,
          onChanged: (value) {
            setState(() {
              task.checked = value;
              _repository.update(task);
            });
          },
        ),
        Expanded(child: Text(task.name)),
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              _repository.delete(task);
            });
          },
        )
      ],
    );
  }

  bool getNextAllCheckedState() {
    for (Task task in _tasks) {
      if (!task.checked) {
        return true;
      }
    }

    return false;
  }
}
