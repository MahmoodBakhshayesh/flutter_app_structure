import 'package:riverpodfuckaround/features/persons/domain/entities/person.dart';
import 'package:riverpodfuckaround/features/persons/domain/interfaces/persons_repository_interface.dart';
import '../../../core/interfaces/base_result.dart';
import '../../../core/interfaces/base_usecase.dart';

class GetPassengersRequest extends Request {

  GetPassengersRequest();

  @override
  Failure? validate() => null;

  @override
  Map<String, dynamic> toJson() {
    return Request.createRequestJson(
      execution: 'FlightDetail',
      body: {'FlightScheduleID': 'flightId'},
    );
  }
}

class GetPassengersResponse extends UseCaseResponse {
  final List<Person> personList;

  GetPassengersResponse({required this.personList});

  factory GetPassengersResponse.fromJson(Map<String, dynamic> json) => GetPassengersResponse(personList: List<Person>.from(json[0].map((x) => Person.fromJson(x))));
}

class GetPassengersUsecase extends UseCase<GetPassengersResponse, GetPassengersRequest> {
  final PersonsRepositoryInterface repo;

  GetPassengersUsecase(this.repo);

  @override
  Future<GetPassengersResponse> exec(GetPassengersRequest request) async {
    return repo.getPassengers(request);
  }
}
