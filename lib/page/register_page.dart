import 'package:flutter/material.dart';
import '../controller/user_controller.dart';
import '../data/img.dart';
import '../data/my_colors.dart';
import '../widget/my_text.dart';
import '../repository/user_repository.dart' as userRepo;
import 'package:mvc_pattern/mvc_pattern.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage();

  @override
  RegisterPageState createState() => new RegisterPageState();
}

class RegisterPageState extends StateMVC<RegisterPage> {
  UserController _con;

  RegisterPageState() : super(UserController()) {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: 30),
                        Container(
                          child: Image.asset(Img.get('main.jpg')),
                        ),
                        // Container(height: 15),
                        // Text("Sensor Viewer",
                        //     style: MyText.title(context).copyWith(
                        //         color: MyColors.grey_80,
                        //         fontWeight: FontWeight.bold)),
                        // Container(height: 5),
                        // Text("회원가입",
                        //     style: MyText.subhead(context).copyWith(
                        //         color: Colors.blueGrey[300],
                        //         fontWeight: FontWeight.bold)),
                        // Spacer(),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => _con.user.email = input,
                          validator: (input) =>
                              input.isEmpty ? '아이디를 입력하세요' : null,
                          decoration: InputDecoration(labelText: "아이디(Email)"),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (input) => _con.user.password = input,
                          validator: (input) =>
                              input.isEmpty ? '비밀번호를 입력하세요' : null,
                          decoration: InputDecoration(labelText: "비밀번호"),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _con.user.name = input,
                          validator: (input) =>
                              input.isEmpty ? '회사명을 입력하세요' : null,
                          decoration: InputDecoration(labelText: "회사명"),
                        ),
                        Container(height: 15),
                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text(
                              "회원가입",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blueGrey[400],
                            onPressed: () {
                              _con.register();
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text(
                              "로그인",
                              style: TextStyle(color: Colors.blueGrey[400]),
                            ),
                            color: Colors.transparent,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/LoginPage');
                            },
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
