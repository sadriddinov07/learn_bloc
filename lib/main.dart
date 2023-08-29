import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:learn_bloc/app.dart';
import 'package:learn_bloc/cubit/detail_cubit/detail_cubit.dart';
import 'package:learn_bloc/cubit/home_cubit/home_cubit.dart';
import 'package:learn_bloc/service/sql_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// service locator
final sql = SQLService();
final homeCubit = HomeCubit();
final detailCubit = DetailCubit();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  /// Sql setting
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, "TodoApp");
  await sql.open(path);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
        Locale('uz', 'UZ'),
      ],
      path: 'assets/languages',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyTodoApp(),
    ),
  );
}
