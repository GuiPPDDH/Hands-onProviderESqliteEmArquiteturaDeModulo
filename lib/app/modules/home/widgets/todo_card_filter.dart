import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasksModel;
  final bool isSelected;

  const TodoCardFilter({
    required this.label,
    required this.taskFilter,
    this.totalTasksModel,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      margin: const EdgeInsets.only(
        right: 10,
      ),
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: isSelected ? context.primaryColor : Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.8),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${totalTasksModel?.totalTasks ?? 0} Tasks',
            style: context.titleStyle.copyWith(
              fontSize: 10,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(
              begin: 0.0,
              end: _getPercentCleared(),
            ),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) => LinearProgressIndicator(
              backgroundColor: isSelected ? context.primaryColorLight : Colors.grey.shade300,
              valueColor:
                  AlwaysStoppedAnimation<Color>(isSelected ? Colors.white : context.primaryColor),
              value: value,
            ),
          )
        ],
      ),
    );
  }

  double _getPercentCleared() {
    final totalTasks = totalTasksModel?.totalTasks ?? 0;
    final totalCleared = totalTasksModel?.totalTasksCleared ?? 0.1;

    if (totalTasks == 0) {
      return 0;
    }

    final percent = (totalCleared * 100) / totalTasks;
    return percent / 100;
  }
}
