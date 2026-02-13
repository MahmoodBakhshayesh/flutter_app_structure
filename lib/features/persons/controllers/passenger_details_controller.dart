import 'dart:developer';
import 'package:riverpodfuckaround/core/helpers/api_handler_hook.dart';
import 'package:riverpodfuckaround/core/interfaces/api_state.dart';
import 'package:riverpodfuckaround/core/interfaces/base_failure.dart';
import 'package:riverpodfuckaround/features/persons/usecases/get_passengers_usecase.dart';

import '../../../core/interfaces/base_result.dart';
import '../domain/entities/person.dart';
import '../domain/interfaces/persons_repository_interface.dart';
import '../usecases/get_passenger_details_usecase.dart';

class PassengerDetailsController extends BaseController {
  final PersonsRepositoryInterface _repository;

  PassengerDetailsController(this._repository);

  Future<ApiState<Person>> getPassengerDetails(String id) async {
    log("getPassengerDetails in controller");

    Person? person;
    final request = GetPassengerDetailsRequest(id: id);
    final response = await _repository.getPassengerDetails(request);
    handleApiRequest(
      apiCall: () => GetPassengerDetailsUsecase(_repository).call(request),
      emitState: (ApiState state) {},
      dataMapper: (a) => a,
    );
    return ApiState.success(person);
  }

  Future<void> getPassengerDetailsNew({
    required String id,
    required void Function(ApiState<Person> apiState) emitState,
  }) async {
    final request = GetPassengerDetailsRequest(id: id);

    await handleApiRequest(
      apiCall: () => GetPassengerDetailsUsecase(_repository).call(request),
      emitState: emitState,
      dataMapper: (person) => person.person,
    );
  }
  Future<void> loadSomeOtherData({
    required String id,
    required void Function(ApiState<String> apiState) emitState,
  }) async {

    await handleApiRequest(
      apiCall: () => GetPassengersUsecase(_repository).call(GetPassengersRequest()),
      emitState: emitState,
      dataMapper: (person) => person.personList.length.toString(),
    );
  }



  void updatePassenger(Person person) {
    // handleApiRequest(
    //   apiCall: ()=>await _repository.getPassengerDetails(request),
    //   emitState: emitState,
    //   dataMapper: dataMapper,
    // );
  }
}
