import 'package:riverpodfuckaround/core/interfaces/result_int.dart';
import 'package:riverpodfuckaround/features/persons/usecases/get_passenger_details_usecase.dart';
import 'package:riverpodfuckaround/features/persons/usecases/get_passengers_usecase.dart';

abstract class PersonsRepositoryInterface {
  Future<Result<GetPassengersResponse>> getPassengers(GetPassengersRequest request);
  Future<Result<GetPassengerDetailsResponse>> getPassengerDetails(GetPassengerDetailsRequest request);
}