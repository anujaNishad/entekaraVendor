import 'failure.dart';

abstract class DataException extends Failure {
  final String errorCode;

  const DataException({
    required super.errorMessage,
    required this.errorCode,
  });
}

class NoDataFoundException extends DataException {
  const NoDataFoundException(
      {required super.errorCode, required super.errorMessage});

  @override
  List<Object?> get props => [errorCode, errorMessage];
}
