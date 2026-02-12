class Person {
  final int id;
  final String firstName;
  final String lastName;
  final String nationality;
  final String passportNo;
  final DateTime birthDate;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nationality,
    required this.passportNo,
    required this.birthDate,
  });

  Person copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? nationality,
    String? passportNo,
    DateTime? birthDate,
  }) =>
      Person(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        nationality: nationality ?? this.nationality,
        passportNo: passportNo ?? this.passportNo,
        birthDate: birthDate ?? this.birthDate,
      );

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    nationality: json["nationality"],
    passportNo: json["passportNo"],
    birthDate: DateTime.parse(json["birthDate"]),
  );

  String get name => "$firstName $lastName";

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "nationality": nationality,
    "passportNo": passportNo,
    "birthDate": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
  };
}