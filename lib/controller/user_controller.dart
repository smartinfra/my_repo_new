import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../helper/helper.dart';
import '../model/user.dart';
import '../repository/user_repository.dart' as repository;

class UserController extends ControllerMVC {
  User user = new User();
  bool hidePassword = true;
  bool loading = false;
  String certNumber = '';
  bool checkNumber = false;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  FirebaseMessaging _firebaseMessaging;
  OverlayEntry loader;

  UserController() {
    loader = Helper.overlayLoader(context);
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((String _deviceToken) {
      user.deviceToken = _deviceToken;
    }).catchError((e) {
      print('Notification not configured');
    });
  }

  void login() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.login(user).then((value) {
        print(value);
        if (value != null && value.apiToken != null) {
          Navigator.of(scaffoldKey.currentContext)
              .pushReplacementNamed('/DashboardPage');
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("이메일 또는 비밀번호를 확인해 주세요."),
          ));
        }
      }).catchError((e) {
        // loader.remove();
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('계정이 존재하지 않습니다.'),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  void register() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      print('asdfadfasdf');
      repository.register(user).then((value) {
        if (value != null && value.apiToken != null) {
          Navigator.of(scaffoldKey.currentContext)
              .pushReplacementNamed('/DashboardPage');
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('예외사항이 발생하였습니다.'),
          ));
        }
      }).catchError((e) {
        // loader.remove();
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('회원가입시 오류가 발생하였습니다.'),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
      ;
    }
  }

  void resetPassword() {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.resetPassword(user).then((value) {
        if (value != null && value == true) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content:
                // Text(S.current.your_reset_link_has_been_sent_to_your_email),
                Text('이메일로 비밀번호 초기화 링크를 전송하였습니다.'),
            action: SnackBarAction(
              label: "로그인",
              onPressed: () {
                Navigator.of(scaffoldKey.currentContext)
                    .pushReplacementNamed('/Login');
              },
            ),
            duration: Duration(seconds: 10),
          ));
        } else {
          loader.remove();
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("이메일전송시 오류가 발생하였습니다."),
          ));
        }
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }
}
