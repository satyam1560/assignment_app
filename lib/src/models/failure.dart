import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int? statusCode;
  final String statusMessage;

  const Failure({
    this.statusCode,
    this.statusMessage = 'something went wrong',
  });

  Failure copyWith({
    int? statusCode,
    String? statusMessage,
  }) {
    return Failure(
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [statusCode, statusMessage];
}
