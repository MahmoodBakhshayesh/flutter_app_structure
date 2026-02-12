import 'result_int.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type>> call({required Params request});
}

class NoParams {
  // @override
  // List<Object?> get props => [];
}