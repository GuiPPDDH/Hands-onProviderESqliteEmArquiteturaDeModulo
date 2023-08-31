import 'package:todo_list_provider/app/core/database/migrations/migration.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration_v1.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration_v2.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration_v3.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [
        MigrationV1(),
        MigrationV2(),
        MigrationV3(),
      ];
  List<Migration> getUpgradeMigration(int version) {
    final migrations = <Migration>[];

    //*Supondo que a versão atual seja versão 3
    //*Se a oldVersion ou versão do usuário for 1, então precisa migrar duas versões
    //*até chegar a atual, ou seja, até a versão 3.
    if (version == 1) {
      migrations.add(MigrationV2());
      migrations.add(MigrationV3());
    }

    //*Aqui nesse caso se for versão 2
    //*Apenas será adicionado a versão 3 que falta pra atualizar 
    //*para a versão atual do banco de dados, ou seja, até a versão 3.
    if (version == 2) {
      migrations.add(MigrationV3());
    }

    return migrations;
  }
}
