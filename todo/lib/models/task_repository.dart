import 'package:uuid/uuid.dart';
import 'package:todo/models/task.dart';

class TaskRepository {
  List<Task> _tasks = <Task>[
    Task("1", true, "ABCDEFG"),
    Task("2", false, "BBBBBB"),
    Task("3", true, "CDEFDEFDEF"),
    Task("4", true, "DEFEFEFEFE"),
    Task("5", false, "GENERATOR"),
  ];

  Uuid _uuid = Uuid();

  List<Task> getAll() => _tasks;

  insert(Task task) {
    _tasks.add(task);
  }

  bool delete(Task task) {
    return _tasks.remove(task);
  }

  bool update(Task task) {
    int index = _tasks.indexWhere((Task t) => t.id == task.id);
    if (index == -1) {
      return false;
    }

    _tasks.removeAt(index);
    _tasks.insert(index, task);

    return true;
  }

  String createNewId() {
    return _uuid.v4();
  }
}
