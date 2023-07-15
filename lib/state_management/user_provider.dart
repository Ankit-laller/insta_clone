import 'package:flutter/material.dart';
import 'package:insta_clone/resources/auth_methods.dart';

import '../models/Users.dart';

class UserProvier with ChangeNotifier{
  Users? _users;
  Users get getUser => _users!;
  Future<void> refreshUser() async{
    Users user = await AuthMethods().getUserDetails();
    _users = user;
    notifyListeners();

  }
}