import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/home_page.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          routers: {
            '/home': (context) => const HomePage(),
          },
          bindings: [
            ChangeNotifierProvider(
              create: (context) => HomeController(),
            ),
          ],
        );
}
