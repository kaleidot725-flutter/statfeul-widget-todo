import 'package:todo/models/task.dart';

extension TaskExt on Task {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'checked': checked ? 1 : 0,
    };
  }
}
