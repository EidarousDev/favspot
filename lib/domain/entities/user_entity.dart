import '../../core/utils/helper_functions.dart';

class UserEntity {
  final String id;
  final String? name;
  final String? username;
  final String? profileImage;
  final String? email;
  final String? description;
  final List? search;

  UserEntity(
      {required this.id,
      this.name,
      required this.username,
      this.profileImage,
      this.email,
      this.description,
      required this.search});

  UserEntity copyWith(
      {String? id,
      String? name,
      String? username,
      String? profileImage,
      String? email,
      String? description,
      List? search}) {
    if (name != null) {
      // search list changes corresponding to the name change.
      search = Helper.searchList(name);
    }
    return UserEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        profileImage: profileImage ?? this.profileImage,
        email: email ?? this.email,
        description: description ?? this.description,
        search: search ?? this.search);
  }
}
