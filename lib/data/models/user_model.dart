import '../../core/config/app_config.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      super.name,
      super.username,
      super.profileImage,
      super.email,
      super.description,
      super.search});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] ?? AppConfig.uid,
        name: json['name'] ?? AppConfig.defaultName,
        username: json['username'],
        profileImage: json['profileImage'],
        email: json['email'],
        description: json['description'] ?? '',
        search: json['search']);
  }

  Map<String, dynamic> toJson() => {
        'name': name ?? AppConfig.defaultName,
        'username': username,
        'profileImage': profileImage ?? AppConfig.defaultAvatar,
        'email': email,
        'description': description ?? "Hey there! I'm using FavSpot",
        'search': search
      };
}
