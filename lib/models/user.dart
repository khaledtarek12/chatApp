import '../constants.dart';

class User {
  final String email;
  final String name;
  final String photo;
  final String statues;

  User(this.email, this.name, this.photo, this.statues);

  factory User.fromJson(jsonData) {
    return User(jsonData[kEmail], jsonData[kName], jsonData[photoConst],
        jsonData[kStatues]);
  }
}
