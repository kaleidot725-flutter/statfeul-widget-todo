import 'package:todo/model/task_repository.dart';

class Singleton {
  static TaskRepository taskRepository = TaskRepository();
}
