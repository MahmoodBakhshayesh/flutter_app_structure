import '../../../core/interfaces/base_result.dart';
import '../../../core/interfaces/base_usecase.dart';
import '../domain/entities/person.dart';
import '../domain/interfaces/persons_repository_interface.dart';

class GetPassengerDetailsRequest extends Request {
  final String id;

  GetPassengerDetailsRequest({required this.id});


  @override
  Failure? validate() => null;

  @override
  Map<String, dynamic> toJson() {
    return Request.createRequestJson(
      execution: 'FlightDetail',
      body: {'FlightScheduleID': id},
    );
  }
}

class GetPassengerDetailsResponse extends UseCaseResponse {
  final Person person;

  GetPassengerDetailsResponse({required this.person});

  factory GetPassengerDetailsResponse.fromJson(Map<String, dynamic> json) => GetPassengerDetailsResponse(person: Person.fromJson(json));
}

class GetPassengerDetailsUsecase extends UseCase<GetPassengerDetailsResponse, GetPassengerDetailsRequest> {
  final PersonsRepositoryInterface repo;

  GetPassengerDetailsUsecase(this.repo);

  @override
  Future<GetPassengerDetailsResponse> exec(GetPassengerDetailsRequest request) async {
    return repo.getPassengerDetails(request);
  }
}
