import '../../models/task_model.dart';

abstract interface class TasksRepository {
  Future<void> save(DateTime dateTime, String description);
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end);
}
