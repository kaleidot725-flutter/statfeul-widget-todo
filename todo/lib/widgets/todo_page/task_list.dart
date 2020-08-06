import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_sort.dart';

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
  final List<Task> _allTasks = List<Task>();
  final List<Task> _tasks = List<Task>();

  String _taskName = "";
  String _sortType = TaskSort.all;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _repository.getAll(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.data != null) {
          _tasks.clear();
          _tasks.addAll(sortTasks(snapshot.data, _sortType));
          _allTasks.clear();
          _allTasks.addAll(snapshot.data);
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
          checkAll();
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
              child: Text(TaskSort.all, style: TextStyle(fontSize: 10)),
              color: (_sortType == TaskSort.all)
                  ? Colors.amber
                  : Colors.transparent,
              textColor: Colors.black,
              onPressed: () {
                setState(() {
                  _sortType = TaskSort.all;
                });
              },
            )),
        SizedBox(
          width: 70,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            child: Text(TaskSort.active, style: TextStyle(fontSize: 10)),
            color: (_sortType == TaskSort.active)
                ? Colors.amber
                : Colors.transparent,
            textColor: Colors.black,
            onPressed: () {
              setState(() {
                _sortType = TaskSort.active;
              });
            },
          ),
        ),
        SizedBox(
          width: 70,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            child: Text(TaskSort.completed, style: TextStyle(fontSize: 10)),
            color: (_sortType == TaskSort.completed)
                ? Colors.amber
                : Colors.transparent,
            textColor: Colors.black,
            onPressed: () {
              setState(() {
                _sortType = TaskSort.completed;
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

  List<Task> sortTasks(List<Task> tasks, String sortType) {
    if (sortType == TaskSort.all) {
      return tasks;
    } else if (sortType == TaskSort.active) {
      return tasks.where((value) => (!value.checked)).toList();
    } else if (sortType == TaskSort.completed) {
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
    } else {
      task.uncheck();
    }
    _repository.update(task);
  }

  void checkAll() {
    var nextState = _tasks.any((task) => task.checked == false);
    _tasks.forEach((task) {
      check(task, nextState);
    });
  }

  String getLeftTaskCount() {
    var count = _allTasks.where((value) => (!value.checked)).toList().length;
    return count.toString() + " LEFT";
  }

  void clearCompleteTasks() {
    var deletableTasks = _allTasks.where((value) => (value.checked)).toList();
    deletableTasks.forEach((value) => {_repository.delete(value)});
  }
}
