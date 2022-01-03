import 'package:flutter/material.dart';
import 'package:sensor_viewer/data/my_colors.dart';
import 'package:sensor_viewer/widget/my_text.dart';
import '../repository/user_repository.dart' as userRepo;

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: MyColors.grey_10,
      appBar: AppBar(
          backgroundColor: Colors.blueGrey[600],
          title: Text("프로필"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            // PopupMenuButton<String>(
            //   onSelected: (String value) {},
            //   itemBuilder: (context) => [
            //     PopupMenuItem(
            //       value: "이름",
            //       child: Text("Settings"),
            //     ),
            //   ],
            // )
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 6),
                        Text("회원정보",
                            style: MyText.subhead(context).copyWith(
                                color: MyColors.grey_80,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(
                            child: Icon(Icons.person, color: MyColors.grey_40),
                            width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${userRepo.currentUser.value.name}",
                                style: MyText.subhead(context).copyWith(
                                    color: MyColors.grey_60,
                                    fontWeight: FontWeight.w500)),
                            Container(height: 2),
                            Text("${userRepo.currentUser.value.email}",
                                style: MyText.caption(context)
                                    .copyWith(color: MyColors.grey_40))
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(
                            child: Icon(Icons.calendar_today,
                                color: MyColors.grey_40),
                            width: 50),
                        Container(width: 15),
                        Text("${userRepo.currentUser.value.createdAt}",
                            style: MyText.subhead(context).copyWith(
                                color: MyColors.grey_60,
                                fontWeight: FontWeight.w500)),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FlatButton(
              child: Text(
                "로그아웃",
                style: TextStyle(color: Colors.grey[800]),
              ),
              // color: Colors.grey[800],
              onPressed: () {
                userRepo.logout().then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/LoginPage', (Route<dynamic> route) => false);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
