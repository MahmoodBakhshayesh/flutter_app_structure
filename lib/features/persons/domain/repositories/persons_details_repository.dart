import 'package:riverpodfuckaround/core/interfaces/result_int.dart';
import 'package:riverpodfuckaround/features/persons/domain/data_sources/persons_data_source_remote.dart';

import 'package:riverpodfuckaround/features/persons/usecases/get_passenger_details_usecase.dart';

import 'package:riverpodfuckaround/features/persons/usecases/get_passengers_usecase.dart';

import '../interfaces/persons_repository_interface.dart';

class PersonsRepository implements PersonsRepositoryInterface {
  PersonsDataSourceRemote personsDataSourceRemote = PersonsDataSourceRemote();
  @override
  Future<Result<GetPassengerDetailsResponse>> getPassengerDetails(GetPassengerDetailsRequest request) async {
    final r = await personsDataSourceRemote.getPassenger(request);
    return Result.ok(r);
  }

  @override
  Future<Result<GetPassengersResponse>> getPassengers(GetPassengersRequest request) async{
    final r = await personsDataSourceRemote.getPassengers(request);
    return Result.ok(r);
  }

}