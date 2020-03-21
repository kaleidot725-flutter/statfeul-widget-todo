import 'package:todo/models/task_repository.dart';

class Singleton {
  static TaskRepository taskRepository = TaskRepository();
}
