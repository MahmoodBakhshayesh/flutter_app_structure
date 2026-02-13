
import 'package:riverpodfuckaround/features/persons/usecases/get_passenger_details_usecase.dart';

import '../../../core/interfaces/base_result.dart';
import '../domain/entities/person.dart';
import '../domain/interfaces/persons_repository_interface.dart';
import '../domain/repositories/persons_details_repository.dart';
import '../usecases/get_passengers_usecase.dart';

class PassengersController {
  final PersonsRepositoryInterface _repository;

  PassengersController(this._repository);

  Future<List<Person>> getPersonList()async {
    List<Person> result =[];
    final request = GetPassengersRequest();
    final response = await _repository.getPassengers(request);
    result = response.personList;
    return result;
  }

  String setMsg(String msg) {
    return msg;
  }
}
