import 'package:todo_list_provider/app/repositories/tasks/tasks_repository.dart';

import './tasks_service.dart';

class TasksServiceImpl implements TasksService {
  final TasksRepository _tasksRepository;

  TasksServiceImpl({required TasksRepository tasksRepository}) : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) async =>
      _tasksRepository.save(date, description);
}
