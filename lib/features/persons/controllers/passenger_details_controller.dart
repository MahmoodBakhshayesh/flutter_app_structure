import 'dart:developer';
import 'package:riverpodfuckaround/core/interfaces/result_int.dart';
import 'package:riverpodfuckaround/features/persons/domain/interfaces/persons_repository_interface.dart';
import 'package:riverpodfuckaround/features/persons/usecases/get_passenger_details_usecase.dart';

import '../domain/entities/person.dart';
import '../domain/repositories/persons_details_repository.dart';

class PassengerDetailsController {
  final PersonsRepositoryInterface _repository;

  PassengerDetailsController(this._repository);

  Future<Person?> getPassengerDetails(int id) async{
    Person? person;
    final request = GetPassengerDetailsRequest(id: id);
    final response = await _repository.getPassengerDetails(request);
    switch(response){
      case Ok<GetPassengerDetailsResponse>():
        person = response.value.person;
      case Err<GetPassengerDetailsResponse>():
    }
    return person;
  }

  void updatePassenger(Person person) {
    // Example function: update logic
    log('Updating passenger ${person.id}');
  }
}
