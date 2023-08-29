part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  final List<Todo> todos;
  final ThemeMode mode;

  const HomeState({
    required this.todos,
    this.mode = ThemeMode.light,
  });
}

class HomeInitial extends HomeState {
  const HomeInitial()
      : super(
          todos: const [],
          mode: ThemeMode.light,
        );
}

class HomeLoading extends HomeState {
  const HomeLoading({
    required super.todos,
    required super.mode,
  });
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure({
    required super.todos,
    required super.mode,
    required this.message,
  });
}

class HomeFetchSuccess extends HomeState {
  const HomeFetchSuccess({
    required super.todos,
    required super.mode,
  });
}
