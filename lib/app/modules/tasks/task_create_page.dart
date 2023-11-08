import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_field.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/widgets/calendar_button.dart';

class TaskCreatePage extends StatelessWidget {
  TaskCreateController _controller;

  TaskCreatePage({required TaskCreateController controller, super.key}) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Form(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Criar tarefa',
                  style: context.titleStyle.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TodoListField(label: ''),
              const SizedBox(
                height: 20,
              ),
              const CalendarButton(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text(
          'Salvar tarefa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: context.primaryColor,
      ),
    );
  }
}
