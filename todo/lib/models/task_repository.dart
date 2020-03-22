import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/singleton.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_ext.dart';
import 'package:uuid/uuid.dart';

class TaskRepository {
  Database _database;
  Uuid _uuid = Uuid();

  TaskRepository();

  Future<List<Task>> getAll() async {
    if (_database == null) {
      _database = await createDatabase();
    }

    List<Map<String, dynamic>> maps = await _database.query("tasks");
    return List.generate(maps.length, (i) {
      return Task(maps[i]["id"], (maps[i]["checked"] == 1), maps[i]["name"]);
    });
  }

  Future<void> insert(Task task) async {
    if (_database == null) {
      _database = await createDatabase();
    }

    _database.insert("tasks", task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(Task task) async {
    if (_database == null) {
      _database = await createDatabase();
    }

    _database.delete("tasks", where: "id = ?", whereArgs: [task.id]);
    return true;
  }

  Future<void> update(Task task) async {
    if (_database == null) {
      _database = await createDatabase();
    }

    _database.update("tasks", task.toMap(), where: "id = ?", whereArgs: [task.id]);
  }

  String createNewId() {
    return _uuid.v4();
  }

  Future<Database> createDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tasks_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id TEXT PRIMARY KEY, name TEXT, checked INTEGER)",
        );
      },
      version: 1,
    );
  }
}
