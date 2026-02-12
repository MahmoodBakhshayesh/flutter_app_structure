import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../../controllers/passengers_controller.dart';
import '../../domain/entities/person.dart';

class PassengersViewState {
  final List<Person> people;
  final String text;

  PassengersViewState({required this.people, required this.text});

  factory PassengersViewState.initial() => PassengersViewState(people: [], text: 'init');

  PassengersViewState copyWith({
    List<Person>? people,
    String? text,
  }) {
    return PassengersViewState(
      people: people ?? this.people,
      text: text ?? this.text,
    );
  }
}

class PassengersNotifier extends AsyncNotifier<PassengersViewState> {
  PassengersController get _controller => GetIt.I<PassengersController>();

  @override
  Future<PassengersViewState> build() async {
    final people = await _controller.getPersonList();
    return PassengersViewState(people: people, text: 'loaded');
  }

  Future<void> setMsg(String msg) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      String msgUpdate = _controller.setMsg(msg);
      final current = state.value ?? PassengersViewState.initial();
      return current.copyWith(text: msgUpdate);
    });
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final passengersNotifierProvider = AsyncNotifierProvider<PassengersNotifier, PassengersViewState>(PassengersNotifier.new);
