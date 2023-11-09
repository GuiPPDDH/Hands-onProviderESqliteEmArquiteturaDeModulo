import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filtros',
          style: context.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: 'Hoje',
                taskFilter: TaskFilterEnum.today,
                totalTasksModel: TotalTasksModel(totalTasks: 20, totalTasksCleared: 5),
                isSelected: context
                        .select<HomeController, TaskFilterEnum>((value) => value.filterSelected) ==
                    TaskFilterEnum.today,
              ),
              TodoCardFilter(
                label: 'Amanhã',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTasksModel: TotalTasksModel(totalTasks: 20, totalTasksCleared: 5),
                isSelected: context
                        .select<HomeController, TaskFilterEnum>((value) => value.filterSelected) ==
                    TaskFilterEnum.tomorrow,
              ),
              TodoCardFilter(
                label: 'Semana',
                taskFilter: TaskFilterEnum.week,
                totalTasksModel: TotalTasksModel(totalTasks: 20, totalTasksCleared: 5),
                isSelected: context
                        .select<HomeController, TaskFilterEnum>((value) => value.filterSelected) ==
                    TaskFilterEnum.week,
              ),
            ],
          ),
        )
      ],
    );
  }
}
