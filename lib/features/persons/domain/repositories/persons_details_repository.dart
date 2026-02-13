import '../../../../core/interfaces/base_result.dart';
import '../../../../di.dart';
import '../../usecases/get_passenger_details_usecase.dart';
import '../../usecases/get_passengers_usecase.dart';
import '../data_sources/persons_data_source_local.dart';
import '../data_sources/persons_data_source_remote.dart';
import '../interfaces/persons_date_source_interface.dart';
import '../interfaces/persons_repository_interface.dart';

class PersonsRepository implements PersonsRepositoryInterface {
  final PersonsDateSourceInterface _remoteSource;
  final PersonsDateSourceInterface _localSource;

  PersonsRepository({required PersonsDateSourceInterface remoteSource, required PersonsDateSourceInterface localSource}) : _localSource = localSource, _remoteSource = remoteSource;

  static PersonsRepositoryInterface get builder => PersonsRepository(
    remoteSource: PersonsDataSourceRemote(locator()),
    localSource: PersonsDataSourceLocal(locator()),
  );

  // PersonsDataSourceRemote personsDataSourceRemote = PersonsDataSourceRemote();

  @override
  Future<GetPassengerDetailsResponse> getPassengerDetails(GetPassengerDetailsRequest request) async {
     return  _remoteSource.getPassengerDetails(request);
  }

  @override
  Future<GetPassengersResponse> getPassengers(GetPassengersRequest request) async {
    return  _remoteSource.getPassengers(request);
  }
}
