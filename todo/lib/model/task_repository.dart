import 'package:todo/model/task.dart';

class TaskRepository {
  List<Task> tasks = <Task>[
    Task(true, "ABCDEFG"),
    Task(false, "BBBBBB"),
    Task(true, "CDEFDEFDEF"),
    Task(true, "DEFEFEFEFE"),
    Task(false, "GENERATOR"),
    Task(true, "FINAL ATTACK"),
    Task(false, "Generator"),
    Task(true, "Hidden Kid"),
    Task(false, "Identical Town"),
  ];

  List<Task> getAll() => tasks;
  
  insert(Task task) {
    tasks.add(task);
  }

  bool delete(Task task) {
    return tasks.remove(task);
  }
}
