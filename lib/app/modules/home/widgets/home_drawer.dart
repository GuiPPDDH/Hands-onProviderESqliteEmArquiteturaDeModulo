import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/service/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://img2.gratispng.com/20180802/xaw/kisspng-clip-art-portable-network-graphics-computer-icons-user-staff-person-man-profile-boss-circle-svg-png-5b62ed560cb369.529707841533209942052.jpg';
                  },
                  builder: (_, value, __) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 30,
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Selector<AuthProvider, String>(
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ?? 'Nome não informado';
                      },
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: context.textTheme.titleSmall,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Alterar nome'),
                    content: TextField(
                      onChanged: (value) => nameVN.value = value,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          final name = nameVN.value;
                          if (name.isEmpty) {
                            Messages.of(context).showError('Nome obrigatório');
                          } else {
                            Loader.show(context);
                            context.read<UserService>().updateDisplayName(name);
                            Loader.hide();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Alterar'),
                      ),
                    ],
                  );
                },
              );
            },
            title: const Text('Alterar nome'),
          ),
          ListTile(
            onTap: () => context.read<AuthProvider>().logout(),
            title: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}
