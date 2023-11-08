abstract interface class TasksRepository {
  Future<void> save(DateTime dateTime, String description);
}
