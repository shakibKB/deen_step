import 'package:equatable/equatable.dart';

class UserAuthModel extends Equatable {
  final int id;
  final String email;
  final String? fullName;
  final bool isGuest;

  const UserAuthModel({
    required this.id,
    required this.email,
    this.fullName,
    this.isGuest = false,
  });

  @override
  List<Object?> get props => [id, email, fullName, isGuest];
}
