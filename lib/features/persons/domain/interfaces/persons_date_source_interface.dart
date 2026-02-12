import 'package:riverpodfuckaround/features/persons/usecases/get_passenger_details_usecase.dart';
import 'package:riverpodfuckaround/features/persons/usecases/get_passengers_usecase.dart';

import '../entities/person.dart';

abstract class PersonsDateSourceInterface {
  Future<GetPassengersResponse> getPassengers(GetPassengersRequest request);
  Future<GetPassengerDetailsResponse> getPassenger(GetPassengerDetailsRequest request);
}