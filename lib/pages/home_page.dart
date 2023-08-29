import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:learn_bloc/cubit/detail_cubit/detail_cubit.dart';
import 'package:learn_bloc/cubit/home_cubit/home_cubit.dart';
import 'package:learn_bloc/main.dart';
import 'package:learn_bloc/pages/update_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    homeCubit.fetchTodos();

    detailCubit.stream.listen(
      (state) {
        if (state is DetailDeleteSuccess ||
            detailCubit.state is DetailCreateSuccess) {
          homeCubit.fetchTodos();
        }
        if (state is DetailDeleteSuccess) {
          homeCubit.fetchTodos();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("app_name").tr(),
        leading: PopupMenuButton<Locale>(
          onSelected: context.setLocale,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: Locale('uz', 'UZ'),
                child: Text("🇺🇿 UZ"),
              ),
              PopupMenuItem(value: Locale('ru', 'RU'), child: Text("🇷🇺 RU")),
              PopupMenuItem(value: Locale('en', 'US'), child: Text("🇺🇸 EN")),
            ];
          },
          icon: const Icon(Icons.language_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              homeCubit.changeMode();
            },
            icon: StreamBuilder(
              initialData: homeCubit.state,
              stream: homeCubit.stream,
              builder: (context, state) {
                return Icon(
                  homeCubit.state.mode == ThemeMode.light
                      ? Icons.light_mode
                      : Icons.dark_mode,
                );
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder<HomeState>(
        initialData: homeCubit.state,
        stream: homeCubit.stream,
        builder: (context, snapshot) {
          final items = snapshot.data!.todos;

          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: items.length,
                itemBuilder: (ctx, i) {
                  final item = items[i];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UpdatePage(id: item.id),
                        ),
                      );
                    },
                    leading: IconButton(
                      onPressed: () {
                        detailCubit.changeComplete(item.id);
                      },
                      icon: Checkbox(
                        value: item.isCompleted,
                        onChanged: (bool? value) {
                          detailCubit.changeComplete(item.id);
                        },
                      ),
                    ),
                    title: Text(item.title),
                    subtitle: Text(item.description),
                    trailing: IconButton(
                      onPressed: () {
                        detailCubit.delete(item.id);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/detail");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
