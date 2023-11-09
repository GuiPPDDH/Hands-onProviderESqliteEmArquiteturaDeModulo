class TaskModel {
  final int id;
  final String description;
  final DateTime dateTime;
  final bool cleared;

  TaskModel({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.cleared,
  });

  factory TaskModel.loadFromDB(Map<String, dynamic> task) {
    return TaskModel(
      id: task['id'],
      description: task['descricao'],
      dateTime: DateTime.parse(task['data_hora']),
      cleared: task['finalizado'] == 1,
    );
  }
}
