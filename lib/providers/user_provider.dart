import 'package:flutter/widgets.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  // ♦ Properties
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  // ♦♦ The "getUser" Method"
  User? get getUser => _user;

  // ♦♦ The "refreshUser()" Method"
  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();

    _user = user;

    notifyListeners();
  }
}
