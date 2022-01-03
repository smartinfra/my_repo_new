import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());

Future<void> setUser(User _user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', json.encode(_user.toMap()));
  currentUser.value = _user;
}

Future<User> getUser(User _email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //  await prefs.clear();
  if (prefs.containsKey('user')) {
    return User.fromJSON(json.decode(prefs.getString('user')));
  } else {
    return User.fromJSON({});
  }
}
