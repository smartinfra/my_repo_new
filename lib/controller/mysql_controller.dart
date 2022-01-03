import 'package:flutter/material.dart';
import 'package:sensor_viewer/repository/setting_repository.dart';
import '../model/user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:mysql1/mysql1.dart';

class MysqlController extends ControllerMVC {
  dynamic conn;
  String email;
  GlobalKey<ScaffoldState> scaffoldKey;

  User user;

  MysqlController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    dbconnect();
  }

  void dbconnect() async {
    var settings = new ConnectionSettings(
        host: '13.209.133.170',
        port: 3306,
        user: 'elounge',
        password: 'uvxnbyd@2019K',
        db: 'db_samrim');
    conn = await MySqlConnection.connect(settings);
  }

  void disconnect() async {
    await conn.close();
  }

  Future<bool> existsEmail(String email) async {
    var _exist = '';
    var _result =
        await conn.query('SELECT email FROM users WHERE email = ? ', [email]);
    for (var row in _result) {
      // print('email: ${row[0]}');
      _exist = row[0];
    }
    return _exist != '' ? true : false;
  }

  void login(String email, String password) async {
    try {
      var _result = await conn.query(
          'SELECT id, email, name FROM users WHERE email = ? and password = ? AND level > ?',
          [email, password, 1]);
      // print(_result);
      if (_result.length > 0) {
        for (var row in _result) {
          user = new User.fromJSON(
              {'id': row[0], 'email': row[1], 'name': row[2]});
        }
        setUser(user);
      } else {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('로그인이 되지 않았습니다. 다시 시도해 주세요.'),
        ));
      }
    } catch (e) {
      print(e);
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('오류가 발생하였습니다.'),
      ));
    }
  }

  void register(String email, String password) async {
    bool _existEmail = false;
    try {
      _existEmail = await existsEmail(email);
      if (_existEmail) {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('중복된 이메일 주소가 있습니다.'),
        ));
      } else {
        var _result = await conn.query(
            'INSERT INTO users SET email = ?, password = ?, level = ?, created_at = NOW(), updated_at = NOW()',
            [email, password, 1]);
        print('Inserted row id=${_result.insertId}');
      }
    } catch (e) {
      print(e);
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('오류가 발생하였습니다.'),
      ));
    }
  }
}
