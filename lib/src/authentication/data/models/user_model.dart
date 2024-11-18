import '/core/utils/typedef.dart';
import '/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
  });

  const UserModel.empty()
      : this(
          id: '_empty.id',
          fullName: '_empty.fullName',
          email: '_empty.email',
        );

  UserModel.fromMap(DataMap data)
      : this(
          id: data['id'],
          fullName: data['fullName'],
          email: data['email'],
        );

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
    );
  }
}
