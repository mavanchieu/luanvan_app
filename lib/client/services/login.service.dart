// import 'dart:ffi';
// import 'dart:math';

// import 'package:app_lv/client/models/login_model.dart';
// import 'package:app_lv/client/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LoginService with ChangeNotifier {
//   bool isLogin = false;
//   late void Function() onLogout;
//   String userId = "";
//   String password = "";
//   String username = "";
//   // late UserModel userModel;

//   LoginResponse? loginResponse;

//   Future<bool> login(String name, String password) async {
//     final response = await http.post(
//       Uri.parse('http://192.168.56.1:3005/api/users/login'),
//       body: jsonEncode({
//         'username': name,
//         'password': password,
//       }),
//       headers: {
//         "Content-Type": "application/json",
//       },
//     );
//     if (response.statusCode == 200) {
//       Map<String, dynamic> responseData = jsonDecode(response.body);
//       if (responseData.isNotEmpty) {
//         isLogin = true;
//       }
//       loginResponse = LoginResponse.fromJson(responseData);

//       // userModel =
//       //     UserModel.fromJson(loginResponse?.user as Map<String, dynamic>);
//       password = loginResponse!.user.password;
//       userId = loginResponse!.user.id!;
//       username = loginResponse!.user.username;

//       // print(userModel);
//       notifyListeners();
//       // print(loginResponse!.message);
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<void> logout() async {
//     isLogin = false;
//     notifyListeners();
//     if (onLogout != null) {
//       onLogout!();
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_lv/client/models/login_model.dart';

class LoginService with ChangeNotifier {
  bool isLogin = false;
  String userId = "";
  String password = "";
  String username = "";
  void Function()? onLogout;
  void Function()? onLogin;

  LoginResponse? loginResponse;

  Future<void> initializeLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('isLogin') ?? false;
    userId = prefs.getString('userId') ?? '';
    username = prefs.getString('username') ?? '';
    password = prefs.getString('password') ?? '';
    notifyListeners();
  }

  Future<bool> login(String name, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.56.1:3005/api/users/login'),
      body: jsonEncode({
        'username': name,
        'password': password,
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.isNotEmpty) {
        isLogin = true;
      }
      loginResponse = LoginResponse.fromJson(responseData);
      this.password = loginResponse!.user.password;
      userId = loginResponse!.user.id!;
      username = loginResponse!.user.username;

      // Save login state
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLogin', true);
      prefs.setString('userId', userId);
      prefs.setString('username', username);
      prefs.setString('password', this.password);

      await createAccess(userId);

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    isLogin = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Gọi callback onLogout nếu có
    if (onLogout != null) {
      onLogout!();
    }

    notifyListeners();
  }

  Future<bool> createAccess(String userId) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:3005/api/access/'),
        body: jsonEncode({
          'userId': userId,
          'date': DateTime.now().toString().split('.')[0],
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        print('hahaha');
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }
}
