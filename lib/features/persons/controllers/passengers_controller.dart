import 'package:riverpodfuckaround/core/interfaces/result_int.dart';

import 'package:riverpodfuckaround/features/persons/usecases/get_passenger_details_usecase.dart';

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
    switch(response){
      case Ok<GetPassengersResponse>():
        result = response.value.persons;
      case Err<GetPassengersResponse>():

    }
    return result;
  }

  String setMsg(String msg) {
    return msg;
  }
}
