import 'package:dio/dio.dart';
import 'package:riverpodfuckaround/core/interfaces/base_data_source.dart';
import 'package:riverpodfuckaround/features/persons/usecases/get_passenger_details_usecase.dart';

import 'package:riverpodfuckaround/features/persons/usecases/get_passengers_usecase.dart';

import '../entities/person.dart';
import '../interfaces/persons_date_source_interface.dart';

class PersonsDataSourceRemote  extends RemoteDataSource implements PersonsDateSourceInterface {
  PersonsDataSourceRemote(super.apiService);

  @override
  Future<GetPassengerDetailsResponse> getPassengerDetails(GetPassengerDetailsRequest request) async {

    try {
      await Future.delayed(Duration(seconds: 6));
      final response = await apiService.get('https://msapi.farateams.com/api/passengers/${request.id}');
      return GetPassengerDetailsResponse(person: Person.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetPassengersResponse> getPassengers(GetPassengersRequest request) async {
    try {
      final response = await apiService.get('https://msapi.farateams.com/api/passengers');
      final List<dynamic> data = response.data;
      return GetPassengersResponse(personList: data.map((json) => Person.fromJson(json)).toList());
    } catch (e) {
      rethrow;
    }
  }
}
