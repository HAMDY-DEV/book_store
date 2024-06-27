import 'package:shared_preferences/shared_preferences.dart';

class Token {
  static SharedPreferences? _sharedToken;
  static init() async {
    _sharedToken = await SharedPreferences.getInstance();
  }

  static siveToken({required String token}) {
    _sharedToken!.setString('token', token);
  }

  static String? getToken() {
    return _sharedToken!.getString('token');
  }

  static Future<bool> removeToken() {
    return _sharedToken!.remove('token');
  }
}
