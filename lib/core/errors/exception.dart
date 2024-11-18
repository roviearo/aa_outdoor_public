import 'package:equatable/equatable.dart';

class APIException extends Equatable {
  const APIException({
    required this.message,
    required this.statusCode,
    this.errorCode,
  });

  final String message;
  final int statusCode;
  final String? errorCode;

  @override
  List<Object?> get props => [message, statusCode, errorCode];
}
