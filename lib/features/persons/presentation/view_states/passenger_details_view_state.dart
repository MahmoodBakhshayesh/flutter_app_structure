import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpodfuckaround/core/interfaces/api_state.dart';
import '../../../../core/helpers/nullable.dart';
import '../../controllers/passengers_controller.dart';
import '../../domain/entities/person.dart';
import '../../controllers/passenger_details_controller.dart';

class PassengerDetailsViewState {
  final int id;
  final ApiState<Person?> person;
  final ApiState<String?> someOtherData;
  final String status;

  PassengerDetailsViewState({
    required this.id,
    this.person = const .notStarted(),
    this.someOtherData = const .notStarted(),
    this.status = 'loading',
  });

  factory PassengerDetailsViewState.initial(int id) => PassengerDetailsViewState(id: id);

  PassengerDetailsViewState copyWith({
    int? id,
    Nullable<ApiState<Person>>? person,
    Nullable<ApiState<String>>? someOtherData,
    String? status,
  }) {
    return PassengerDetailsViewState(
      id: id ?? this.id,
      person: person == null ? this.person : person.value,
      someOtherData: someOtherData == null ? this.someOtherData : someOtherData.value,
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
    // We return initial state first, then load data.
    // Riverpod's AsyncNotifier build can return a Future.
    // To handle the ApiState updates from the controller, we'll trigger the fetch.
    await Future.delayed(Duration(seconds: 2));
    // We start with notStarted
    final initialState = PassengerDetailsViewState.initial(id);

    // Use future to ensure we don't block build return but start the request
    Future(() => getPassengerDetails());
    Future(() => loadSomeOtherData());

    return initialState;
  }

  Future<void> getPassengerDetails() async {
    await _controller.getPassengerDetailsNew(
      id: id.toString(),
      emitState: (apiState) {
        if (ref.mounted) {
          state = AsyncData(state.value!.copyWith(person: Nullable(apiState)));
        }
      },
    );
  }

  Future<void> loadSomeOtherData() async {
    await _controller.loadSomeOtherData(
      id: id.toString(),
      emitState: (apiState) {
        if (ref.mounted) {
          state = AsyncData(
            state.value!.copyWith(
              someOtherData: Nullable(apiState),
            ),
          );
        }
      },
    );
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

final passengerDetailsNotifierProvider = AsyncNotifierProvider.autoDispose.family<PassengerDetailsNotifier, PassengerDetailsViewState, int>(
  retry: retry,
  (arg) => PassengerDetailsNotifier(arg),
);

Duration? retry(int retryCount, Object error) {
  retryCount = 0;
  return null;
}
