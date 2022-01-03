import 'package:flutter/material.dart';
import '../controller/user_controller.dart';
import '../data/img.dart';
import '../data/my_colors.dart';
import '../widget/my_text.dart';
import '../repository/user_repository.dart' as userRepo;
import 'package:mvc_pattern/mvc_pattern.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends StateMVC<LoginPage> {
  UserController _con;

  LoginPageState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    // if (userRepo.currentUser.value.apiToken != null) {
    //   Navigator.of(context).pushReplacementNamed('/DashboardPage');
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _con.scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            child: Container(), preferredSize: Size.fromHeight(0)),
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _con.loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(height: 30),
                        Container(
                          child: Image.asset(Img.get('main.jpg')),
                          // width: 80,
                          // height: 80,
                        ),
                        // Container(height: 15),
                        // Text("S.BRIDGE+",
                        //     style: MyText.title(context).copyWith(
                        //         color: MyColors.grey_80,
                        //         fontWeight: FontWeight.bold)),
                        // Container(height: 5),
                        // Text("로그인 해 주세요",
                        //     style: MyText.subhead(context).copyWith(
                        //         color: Colors.blueGrey[300],
                        //         fontWeight: FontWeight.bold)),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => _con.user.email = input,
                          validator: (input) =>
                              input.isEmpty ? '아이디를 입력하세요' : null,
                          decoration: InputDecoration(labelText: "아이디"),
                        ),
                        // Container(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (input) => _con.user.password = input,
                          validator: (input) =>
                              input.isEmpty ? '비밀번호를 입력해 주세요' : null,
                          decoration: InputDecoration(labelText: "비밀번호"),
                        ),
                        Container(height: 15),
                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text(
                              "로그인",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blueGrey[400],
                            onPressed: () {
                              _con.login();
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                child: Text(
                                  "회원가입",
                                  style: TextStyle(color: Colors.blueGrey[400]),
                                ),
                                color: Colors.transparent,
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/RegisterPage');
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  "비밀번호찾기",
                                  style: TextStyle(color: Colors.blueGrey[400]),
                                ),
                                color: Colors.transparent,
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                      mainAxisSize: MainAxisSize.min,
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
