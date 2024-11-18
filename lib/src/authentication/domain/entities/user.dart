import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.fullName,
    required this.email,
  });

  const User.empty()
      : this(
          id: '_empty.id',
          fullName: '_empty.fullName',
          email: '_empty.email',
        );

  final String id;
  final String fullName;
  final String email;

  @override
  List<Object?> get props => [id];
}
