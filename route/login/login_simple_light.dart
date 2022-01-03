import 'package:flutter/material.dart';
import '../../controller/mysql_controller.dart';
import '../../data/img.dart';
import '../../data/my_colors.dart';
import '../../data/my_strings.dart';
import '../../widget/my_text.dart';
import '../../widget/toolbar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LoginSimpleLightRoute extends StatefulWidget {
  LoginSimpleLightRoute();

  @override
  LoginSimpleLightRouteState createState() => new LoginSimpleLightRouteState();
}

class LoginSimpleLightRouteState extends StateMVC<LoginSimpleLightRoute> {
  MysqlController _con;

  LoginSimpleLightRouteState() : super(MysqlController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.dbconnect();
    super.initState();
  }

  @override
  void dispose() {
    _con.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _con.scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar:
          PreferredSize(child: Container(), preferredSize: Size.fromHeight(0)),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: 30),
            Container(
              child: Image.asset(Img.get('logo_small.png')),
              width: 80,
              height: 80,
            ),
            Container(height: 15),
            Text("Sensor Viewer",
                style: MyText.title(context).copyWith(
                    color: MyColors.grey_80, fontWeight: FontWeight.bold)),
            Container(height: 5),
            Text("로그인 해 주세요",
                style: MyText.subhead(context).copyWith(
                    color: Colors.blueGrey[300], fontWeight: FontWeight.bold)),
            Spacer(),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Email"),
            ),
            Container(height: 25),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Password"),
            ),
            Container(height: 5),
            Row(
              children: <Widget>[
                Spacer(),
                FlatButton(
                  child: Text(
                    "비밀번호찾기",
                    style: TextStyle(color: Colors.purpleAccent[400]),
                  ),
                  color: Colors.transparent,
                  onPressed: () {},
                )
              ],
            ),
            Container(
              width: double.infinity,
              child: FlatButton(
                child: Text(
                  "로그인",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.purpleAccent[400],
                onPressed: () {
                  // _con.login('nfree4u@gmail.com', '1234');
                  _con.register('bbb@gmail.com', '1234');
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: FlatButton(
                child: Text(
                  "회원가입",
                  style: TextStyle(color: Colors.purpleAccent[400]),
                ),
                color: Colors.transparent,
                onPressed: () {},
              ),
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
