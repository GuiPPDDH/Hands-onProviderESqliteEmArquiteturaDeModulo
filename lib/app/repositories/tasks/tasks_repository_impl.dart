import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';

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
}
