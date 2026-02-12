import 'package:dio/dio.dart';
import 'package:riverpodfuckaround/features/persons/usecases/get_passenger_details_usecase.dart';

import 'package:riverpodfuckaround/features/persons/usecases/get_passengers_usecase.dart';

import '../entities/person.dart';
import '../interfaces/persons_date_source_interface.dart';

class PersonsDataSourceRemote implements PersonsDateSourceInterface {
  Dio dio = Dio();

  @override
  Future<GetPassengerDetailsResponse> getPassenger(GetPassengerDetailsRequest request) async {

    try {
      // Assuming endpoint structure for getting a single passenger
      final response = await dio.get('https://msapi.farateams.com/api/passengers/${request.id}');
      return GetPassengerDetailsResponse(person: Person.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetPassengersResponse> getPassengers(GetPassengersRequest request) async {
    try {
      final response = await dio.get('https://msapi.farateams.com/api/passengers');
      final List<dynamic> data = response.data;
      return GetPassengersResponse(persons: data.map((json) => Person.fromJson(json)).toList());
    } catch (e) {
      rethrow;
    }
  }
}
