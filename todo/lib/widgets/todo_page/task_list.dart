import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/task.dart';
import '../../models/task_repository.dart';
import '../../singleton.dart';

class TaskList extends StatefulWidget {
  TaskList({Key key}) : super(key: key);

  @override
  _TaskListState createState() {
    var state = _TaskListState();
    return state;
  }
}

class _TaskListState extends State<TaskList> {
  final TextEditingController _taskNameControler = new TextEditingController();
  final TaskRepository _repository = Singleton.taskRepository;
  final List<Task> _tasks = List<Task>();

  String _taskName = "";
  String _sortType = "ALL";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _repository.getAll(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.data != null) {
          _tasks.clear();
          _tasks.addAll(sortTasks(snapshot.data, _sortType));
        }

        return Container(
            child: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Row(children: <Widget>[
                buildAllCheckButton(),
                buildTaskNameTextField(),
                buildTaskAddButton(),
              ])),
          Expanded(child: buildTaskListView()),
          buildSortMenu(),
        ]));
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
            check(task, nextState);
          }
        });
      },
    );
  }

  Widget buildTaskNameTextField() {
    return Expanded(
        child: TextField(
      controller: _taskNameControler,
      onChanged: (String text) {
        updateTaskName(text);
      },
    ));
  }

  Widget buildTaskAddButton() {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        setState(() {
          add(Task(_repository.createNewId(), false, _taskName));
          clearTaskName();
        });
      },
    );
  }

  Widget buildTaskListView() {
    return ListView.builder(
        itemCount: (_tasks != null) ? _tasks.length : 0,
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
              check(task, value);
            });
          },
        ),
        Expanded(child: Text(task.name)),
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              delete(task);
            });
          },
        )
      ],
    );
  }

  Widget buildSortMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
            width: 70,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Text(getLeftTaskCount(),
                  style: TextStyle(fontSize: 10, color: Colors.black)),
              color: Colors.transparent,
              textColor: Colors.amber,
            )),
        SizedBox(
            width: 70,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Text("ALL", style: TextStyle(fontSize: 10)),
              color: (_sortType == "ALL") ? Colors.amber : Colors.transparent,
              textColor: Colors.black,
              onPressed: () {
                setState(() {
                  _sortType = "ALL";
                });
              },
            )),
        SizedBox(
          width: 70,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            child: Text("ACTIVE", style: TextStyle(fontSize: 10)),
            color: (_sortType == "ACTIVE") ? Colors.amber : Colors.transparent,
            textColor: Colors.black,
            onPressed: () {
              setState(() {
                _sortType = "ACTIVE";
              });
            },
          ),
        ),
        SizedBox(
          width: 70,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            child: Text("COMPLETED", style: TextStyle(fontSize: 10)),
            color:
                (_sortType == "COMPLETED") ? Colors.amber : Colors.transparent,
            textColor: Colors.black,
            onPressed: () {
              setState(() {
                _sortType = "COMPLETED";
              });
            },
          ),
        ),
        SizedBox(
          width: 70,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            child: Text("CLEAR\nCOMPLETED", style: TextStyle(fontSize: 10)),
            color: Colors.transparent,
            textColor: Colors.black,
            onPressed: () {
              setState(() {
                clearCompleteTasks();
              });
            },
          ),
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

  List<Task> sortTasks(List<Task> tasks, String sortType) {
    if (sortType == "ALL") {
      return tasks;
    } else if (sortType == "ACTIVE") {
      return tasks.where((value) => (!value.checked)).toList();
    } else if (sortType == "COMPLETED") {
      return tasks.where((value) => (value.checked)).toList();
    } else {
      return tasks;
    }
  }

  void updateTaskName(String taskName) {
    _taskName = taskName;
  }

  void clearTaskName() {
    _taskName = "";
    _taskNameControler.clear();
  }

  void add(Task task) {
    _repository.insert(task);
  }

  void delete(Task task) {
    _repository.delete(task);
  }

  void check(Task task, bool value) {
    if (value) {
      task.check();
    }
    else {
      task.uncheck();
    }
    _repository.update(task);
  }

  String getLeftTaskCount() {
    var count = _tasks.where((value) => (!value.checked)).toList().length;
    return count.toString() + " LEFT";
  }

  void clearCompleteTasks() {
    var deletableTasks = _tasks.where((value) => (value.checked)).toList();
    _tasks.remove(deletableTasks);
    deletableTasks.forEach((value) => {_repository.delete(value)});
  }
}
