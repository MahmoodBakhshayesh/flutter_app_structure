import 'package:riverpodfuckaround/features/persons/domain/entities/person.dart';

class GetPassengerDetailsUsecase {

}

class GetPassengerDetailsRequest {
  final int id;

  GetPassengerDetailsRequest({required this.id});
}

class GetPassengerDetailsResponse {
  final Person person;

  GetPassengerDetailsResponse({required this.person});
}