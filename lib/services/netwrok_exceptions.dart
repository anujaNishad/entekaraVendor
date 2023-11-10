import 'failure.dart';

abstract class NetworkExcpetion extends Failure {
  final int statusCode;

  const NetworkExcpetion({
    required this.statusCode,
    required super.errorMessage,
  });
}

class NoContentException extends NetworkExcpetion {
  const NoContentException(
      {required super.statusCode, required super.errorMessage});

  @override
  List<Object?> get props => [statusCode, errorMessage];
}

class NotFoundException extends NetworkExcpetion {
  const NotFoundException(
      {required super.statusCode, required super.errorMessage});

  @override
  List<Object?> get props => [statusCode, errorMessage];
}

class InternalServerError extends NetworkExcpetion {
  const InternalServerError(
      {required super.statusCode, required super.errorMessage});

  @override
  List<Object?> get props => [statusCode, errorMessage];
}

class NoInternet extends NetworkExcpetion {
  const NoInternet({required super.statusCode, required super.errorMessage});

  @override
  List<Object?> get props => [statusCode, errorMessage];
}

class UnAuthorisedError extends NetworkExcpetion {
  const UnAuthorisedError(
      {required super.statusCode, required super.errorMessage});

  @override
  List<Object?> get props => [statusCode, errorMessage];
}
