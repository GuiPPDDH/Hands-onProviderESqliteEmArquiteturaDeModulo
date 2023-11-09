import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import './tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime dateTime, String description) async {
    final connection = await _sqliteConnectionFactory.openConnection();
    await connection.insert(
      'todo',
      {
        'id': null,
        'descricao': description,
        'data_hora': dateTime.toIso8601String(),
        'finalizado': 0,
      },
    );
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final connection = await _sqliteConnectionFactory.openConnection();
    final result = await connection.rawQuery('''
      select *
      from todo
      where data_hora between ? and ?
      order by data_hora
    ''', [
      startFilter.toIso8601String(),
      endFilter.toIso8601String(),
    ]);

    return result.map((task) => TaskModel.loadFromDB(task)).toList();
  }
}
