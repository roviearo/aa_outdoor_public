import 'package:equatable/equatable.dart';

import 'exception.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.statusCode,
    this.errorCode,
  });

  final String message;
  final int statusCode;
  final String? errorCode;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object?> get props => [message, statusCode, errorCode];
}

class APIFailure extends Failure {
  const APIFailure(
      {required super.message, required super.statusCode, super.errorCode});

  APIFailure.fromException(APIException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
          errorCode: exception.errorCode,
        );
}
