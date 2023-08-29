import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:learn_bloc/main.dart';
import 'package:learn_bloc/pages/detail_page.dart';
import 'package:learn_bloc/pages/home_page.dart';

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: homeCubit.state,
      stream: homeCubit.stream,
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: homeCubit.state.mode,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: "/",
          routes: {
            "/": (context) => const HomePage(),
            "/detail": (context) => DetailPage(),
          },
        );
      },
    );
  }
}
