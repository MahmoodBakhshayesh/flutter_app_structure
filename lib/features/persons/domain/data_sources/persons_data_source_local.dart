import 'package:dio/dio.dart';
import 'package:riverpodfuckaround/core/interfaces/base_data_source.dart';
import 'package:riverpodfuckaround/features/persons/usecases/get_passenger_details_usecase.dart';

import 'package:riverpodfuckaround/features/persons/usecases/get_passengers_usecase.dart';

import '../entities/person.dart';
import '../interfaces/persons_date_source_interface.dart';

class PersonsDataSourceLocal extends LocalDataSource implements PersonsDateSourceInterface {
  PersonsDataSourceLocal(super.keyValueStore);

  @override
  Future<GetPassengerDetailsResponse> getPassengerDetails(GetPassengerDetailsRequest request) {
    // TODO: implement getPassenger
    throw UnimplementedError();
  }

  @override
  Future<GetPassengersResponse> getPassengers(GetPassengersRequest request) {
    // TODO: implement getPassengers
    throw UnimplementedError();
  }

}
