import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  SharedPreferences? prefs;

  void setEmail({required String email}) async{
    prefs = await SharedPreferences.getInstance();
    await prefs!.setString('email', email);
  }

  // void setPassword({required String password}) async{
  //   prefs = await SharedPreferences.getInstance();
  //   await prefs!.setString('password', password);
  // }

  void removeEmail() async{
    prefs = await SharedPreferences.getInstance();
    await prefs!.remove('email');
  }
  // void removePassword() async{
  //   prefs = await SharedPreferences.getInstance();
  //   await prefs!.remove('password');
  // }

  Future<String?> getEmail() async{
    prefs = await SharedPreferences.getInstance();
    return prefs?.getString('email');
  }

  // Future<String?> getPassword() async{
  //   prefs = await SharedPreferences.getInstance();
  //   return prefs?.getString('password');
  // }
}
