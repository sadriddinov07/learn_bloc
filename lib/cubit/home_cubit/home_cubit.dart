import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:learn_bloc/main.dart';
import 'package:learn_bloc/model/todo_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  void fetchTodos() async {
    emit(
      HomeLoading(todos: state.todos, mode: ThemeMode.light),
    );
    try {
      final todos = await sql.todos();
      emit(
        HomeFetchSuccess(todos: todos, mode: ThemeMode.light),
      );
    } catch (e) {
      emit(
        HomeFailure(
          todos: state.todos,
          mode: ThemeMode.light,
          message: "HOME ERROR: $e",
        ),
      );
    }
  }

  void changeComplete(int id) async {
    final todo =
        homeCubit.state.todos.where((element) => element.id == id).first;
    todo.isCompleted = !todo.isCompleted;
    await sql.update(todo);
    emit(
      HomeFetchSuccess(
        todos: state.todos,
        mode: state.mode,
      ),
    );
  }

  void changeMode() {
    try {
      emit(
        HomeFetchSuccess(
          todos: state.todos,
          mode:
              state.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
        ),
      );
    } catch (e) {
      emit(
        HomeFailure(
          todos: state.todos,
          mode: ThemeMode.light,
          message: "HOME ERROR: $e",
        ),
      );
    }
  }
}
