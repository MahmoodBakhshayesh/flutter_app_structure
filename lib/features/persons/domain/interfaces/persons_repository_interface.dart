import '../../../../core/interfaces/base_result.dart';
import '../../usecases/get_passenger_details_usecase.dart';
import '../../usecases/get_passengers_usecase.dart';

abstract class PersonsRepositoryInterface {
  Future<GetPassengersResponse> getPassengers(GetPassengersRequest request);
  Future<GetPassengerDetailsResponse> getPassengerDetails(GetPassengerDetailsRequest request);
}