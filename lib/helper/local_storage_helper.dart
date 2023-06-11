import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  static late SharedPreferences pref;

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static void saveCredentials(String username, String password) {
    if (username.isNotEmpty && password.isNotEmpty) {
      pref.setString('username', username);
      pref.setString('password', password);
    }
  }

  static UserModel getCredentials() {
    return UserModel(
        pref.getString('username') ?? "", pref.getString('password') ?? "");
  }
}

class UserModel {
  String email;
  String password;

  UserModel(this.email, this.password);
}
