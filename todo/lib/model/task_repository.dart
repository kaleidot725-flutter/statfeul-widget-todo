import 'package:todo/model/task.dart';

class TaskRepository {
  List<Task> tasks = <Task>[
    Task(1, true, "ABCDEFG"),
    Task(2, false, "BBBBBB"),
    Task(3, true, "CDEFDEFDEF"),
    Task(4, true, "DEFEFEFEFE"),
    Task(5, false, "GENERATOR"),
    Task(6, true, "FINAL ATTACK"),
    Task(7, false, "Generator"),
    Task(8, true, "Hidden Kid"),
    Task(9, false, "Identical Town"),
  ];

  List<Task> getAll() => tasks;

  insert(Task task) {
    tasks.add(task);
  }

  bool delete(Task task) {
    return tasks.remove(task);
  }

  bool update(Task task) {
    int index = tasks.indexWhere((Task t) => t.id == task.id);
    if (index == -1) {
      return false;
    }

    tasks.removeAt(index);
    tasks.insert(index, task);

    return true;
  }
}
