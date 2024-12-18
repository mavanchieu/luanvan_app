import 'dart:io';

import 'package:app_lv/client/models/user_model.dart';
import 'package:app_lv/client/services/user.service.dart';
import 'package:app_lv/client/ui/account/profile/edit_name.dart';
import 'package:app_lv/client/ui/account/profile/edit_phone.dart';
import 'package:flutter/material.dart';

class UserManager with ChangeNotifier {
  late UserModel _user;
  UserModel get user => _user;

  late List<UserModel> _allUsers;
  List<UserModel> get allUser => _allUsers;

  Future<UserModel> fetchUsers(String userId) async {
    try {
      var userService = UserService();
      _user = await userService.getUserById(userId);
      notifyListeners();
      return _user;
    } catch (e) {
      print(e);
    }
    return _user;
  }

  Future<List<UserModel>> fetchAllUsers() async {
    try {
      var userService = UserService();
      _allUsers = await userService.getAllUsers();
      print(_allUsers.length);
      notifyListeners();
      return _allUsers;
    } catch (e) {
      print(e);
    }
    return _allUsers;
  }

  Future<bool> editPassword(String userId, String password) async {
    try {
      final userService = UserService();
      bool message = await userService.editPassword(userId, password);
      if (message) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> editFullname(String userId, String fullname) async {
    try {
      final userService = UserService();
      bool message = await userService.editFullname(userId, fullname);
      if (message) {
        fetchUsers(userId);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> editGender(String userId, String gender) async {
    try {
      final userService = UserService();
      bool message = await userService.editGender(userId, gender);
      if (message) {
        fetchUsers(userId);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> editEmail(String userId, String email) async {
    try {
      final userService = UserService();
      bool message = await userService.editEmail(userId, email);
      if (message) {
        fetchUsers(userId);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> editPhone(String userId, String phone) async {
    try {
      final userService = UserService();
      bool message = await userService.editPhone(userId, phone);
      if (message) {
        fetchUsers(userId);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> editDate(String userId, String date) async {
    try {
      final userService = UserService();
      bool message = await userService.editDate(userId, date);
      if (message) {
        fetchUsers(userId);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateImage(String userId, File image) async {
    try {
      final userService = UserService();
      bool message = await userService.updateImage(userId, image);
      if (message) {
        fetchUsers(userId);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
