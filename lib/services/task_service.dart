import '../helpers/db_helper.dart';
import '../models/task.dart';

class TaskService {
  final dbHelper = DatabaseHelper();

  Future<List<Task>> getTasks() async {
    try {
      final db = await dbHelper.database;
      final maps = await db.query('tasks', where: "deleted=0");
      print("REGISTROS");
      print(maps);
      return maps.map((map) => Task.fromMap(map)).toList();
    } catch (error) {
      print("ERROR AL OBTENER TASKs");
      print(error);
    }
    return [];
  }

  Future<void> addTask(Task task) async {
    final db = await dbHelper.database;
    try {
      await db.insert('tasks', task.toMap());
    } catch (error) {
      print("ERROR AL INSERTAR TASK");
      print(task);
      print(error);
    }
  }

  Future<void> updateTask(Task task) async {
    final db = await dbHelper.database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await dbHelper.database;
     await db.update(
      'tasks',
      {'deleted': 1},
      where: 'id = ?',
     whereArgs: [id],
    );
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }


Future<void> deleteSelectedTasks(List<int> ids) async {
  if (ids.isEmpty) return; // nada que borrar 
  final db = await dbHelper.database; 
  await db.update(
    'tasks',
    {'deleted': 1},
    where: 'id IN (${List.filled(ids.length, '?').join(',')})',
    whereArgs: ids,
  ); 
}

   Future<void> setCompletedTask(int id,bool completed) async {
    final db = await dbHelper.database;
     await db.update(
      'tasks',
      {'completed': completed ? 1 : 0 },
      where: 'id = ?',
     whereArgs: [id],
    ); 
  }

  Future<int> selectedCount() async {
    final tasks = await getTasks();
    return tasks.where((t) => t.completed).length;
  }
}
