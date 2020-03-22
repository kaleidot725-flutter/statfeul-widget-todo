import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task_repository.dart';

class Singleton {
  static TaskRepository taskRepository = TaskRepository();
}
