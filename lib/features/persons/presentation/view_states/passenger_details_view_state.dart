import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../../controllers/passengers_controller.dart';
import '../../domain/entities/person.dart';
import '../../controllers/passenger_details_controller.dart';

class PassengerDetailsViewState {
  final int id;
  final Person? person;
  final String status;

  PassengerDetailsViewState({
    required this.id,
    this.person,
    this.status = 'loading',
  });

  factory PassengerDetailsViewState.initial(int id) => PassengerDetailsViewState(id: id);

  PassengerDetailsViewState copyWith({
    int? id,
    Person? person,
    String? status,
  }) {
    return PassengerDetailsViewState(
      id: id ?? this.id,
      person: person ?? this.person,
      status: status ?? this.status,
    );
  }
}

class PassengerDetailsNotifier extends AsyncNotifier<PassengerDetailsViewState> {
  final int id;

  PassengerDetailsNotifier(this.id);

  PassengerDetailsController get _controller => GetIt.I<PassengerDetailsController>();
  PassengersController get _paxController => GetIt.I<PassengersController>();

  @override
  Future<PassengerDetailsViewState> build() async {
    // Initial state with ID
    // Note: We can't set state directly in build immediately if we yield async.
    // But we return the initial state or loading state.

    // Fetch details using controller
    // We can't use 'state = ...' before 'build' returns in AsyncNotifier usually?
    // Actually AsyncNotifier build returns Future<State>.

    final person = await _controller.getPassengerDetails(id);
    return PassengerDetailsViewState(id: id, person: person, status: 'loaded');
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> setMsg(String msg) async {
    state = await AsyncValue.guard(() async {
      String msgUpdate = _paxController.setMsg(msg);
      final current = state.value!;
      return current.copyWith(status: msgUpdate);
    });
  }
}

final passengerDetailsNotifierProvider = AsyncNotifierProvider.family<PassengerDetailsNotifier, PassengerDetailsViewState, int>(
  (arg) => PassengerDetailsNotifier(arg),
);
