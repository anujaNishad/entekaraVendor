import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

class NetworkException extends Failure {
  const NetworkException() : super(errorMessage: '');

  @override
  List<Object?> get props => [errorMessage];
}
