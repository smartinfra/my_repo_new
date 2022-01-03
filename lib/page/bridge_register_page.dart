import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../controller/bridge_controller.dart';
import '../model/bridge.dart';
import '../data/my_colors.dart';
import '../widget/my_text.dart';
import '../repository/user_repository.dart' as userRepo;
import 'package:mvc_pattern/mvc_pattern.dart';

class BridgeRegisterPage extends StatefulWidget {
  final Bridge bridge;

  BridgeRegisterPage({Key key, this.bridge}) : super(key: key);

  @override
  BridgeRegisterPageState createState() => new BridgeRegisterPageState();
}

class BridgeRegisterPageState extends StateMVC<BridgeRegisterPage> {
  BridgeController _con;

  BridgeRegisterPageState() : super(BridgeController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.bridge = widget.bridge;
    // print(_con.bridge.address);
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
                    key: _con.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Container(height: 30),
                        // Container(
                        //   child: Image.asset(Img.get('logo_small.png')),
                        //   width: 80,
                        //   height: 80,
                        // ),
                        Container(height: 15),
                        Text("Sensor Viewer",
                            style: MyText.title(context).copyWith(
                                color: MyColors.grey_80,
                                fontWeight: FontWeight.bold)),
                        Container(height: 5),
                        Text(widget.bridge.id == null ? "교량등록" : "교량수정",
                            style: MyText.subhead(context).copyWith(
                                color: Colors.blueGrey[300],
                                fontWeight: FontWeight.bold)),
                        Container(height: 15),
                        Center(
                          child: _con.file == null
                              ? (widget.bridge.image != null &&
                                      widget.bridge.image.thumb != null
                                  ? CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: widget.bridge.image.thumb,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text('이미지를 선택해 주세요'),
                                    ))
                              : Image.file(
                                  _con.file,
                                  fit: BoxFit.fill,
                                ),
                        ),
                        _con.uploaded == false
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  OutlineButton(
                                    onPressed: _con.chooseImage,
                                    child: Text('이미지선택'),
                                  ),
                                  SizedBox(width: 5),
                                  OutlineButton(
                                    onPressed: _con.startUpload,
                                    child: Text('업로드'),
                                  ),
                                ],
                              )
                            : Center(
                                child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('정상적으로 업로드되었습니다!'),
                              )),
                        TextFormField(
                          initialValue: widget.bridge.name,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _con.bridge.name = input,
                          validator: (input) =>
                              input.isEmpty ? '교량명을 입력하세요' : null,
                          decoration: InputDecoration(labelText: "교량명"),
                        ),
                        // TextFormField(
                        //   initialValue: widget.bridge.address,
                        //   keyboardType: TextInputType.text,
                        //   onSaved: (input) => _con.bridge.address = input,
                        //   onChanged: (input) {
                        //     _con.bridge.address = input;
                        //   },
                        //   validator: (input) =>
                        //       input.isEmpty ? '교량주소를 입력하세요' : null,
                        //   decoration: InputDecoration(
                        //       labelText: "교량주소",
                        //       suffixIcon: IconButton(
                        //           icon: Icon(Icons.search),
                        //           onPressed: () {
                        //             if (_con.bridge.address == '' ||
                        //                 _con.bridge.address == null) {
                        //               FocusScope.of(context).unfocus();
                        //               Scaffold.of(context).showSnackBar(
                        //                   SnackBar(
                        //                       content: Text("교량주소를 입력해 주세요")));
                        //             } else {
                        //               print(_con.bridge.address);
                        //               Navigator.of(context).pushNamed(
                        //                   '/MapPage',
                        //                   arguments: _con.bridge);
                        //             }
                        //           })),
                        // ),
                        // TextFormField(
                        //   initialValue: widget.bridge.latitude,
                        //   keyboardType: TextInputType.text,
                        //   onSaved: (input) => _con.bridge.latitude = input,
                        //   validator: (input) =>
                        //       input.isEmpty ? '위도를 입력하세요' : null,
                        //   decoration: InputDecoration(
                        //     labelText: "위도",
                        //   ),
                        // ),
                        // TextFormField(
                        //   initialValue: widget.bridge.longitude,
                        //   keyboardType: TextInputType.text,
                        //   onSaved: (input) => _con.bridge.longitude = input,
                        //   validator: (input) =>
                        //       input.isEmpty ? '경도를 입력하세요' : null,
                        //   decoration: InputDecoration(labelText: "경도"),
                        // ),
                        TextFormField(
                          initialValue: widget.bridge.superstructureType,
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                              _con.bridge.superstructureType = input,
                          validator: (input) =>
                              input.isEmpty ? '상부구조형식을 입력하세요' : null,
                          decoration: InputDecoration(labelText: "상부구조형식"),
                        ),
                        TextFormField(
                          initialValue: widget.bridge.constructionYear,
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                              _con.bridge.constructionYear = input,
                          validator: (input) =>
                              input.isEmpty ? '준공연도를 입력하세요' : null,
                          decoration: InputDecoration(labelText: "준공연도"),
                        ),
                        /*
                        TextFormField(
                          initialValue: widget.bridge.bridgeExtension,
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                              _con.bridge.bridgeExtension = input,
                          validator: (input) =>
                              input.isEmpty ? '교량연장을 입력하세요' : null,
                          decoration: InputDecoration(labelText: "교량연장"),
                        ),
                        TextFormField(
                          initialValue: widget.bridge.designLoad,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _con.bridge.designLoad = input,
                          validator: (input) =>
                              input.isEmpty ? '설계활하중을 입력하세요' : null,
                          decoration: InputDecoration(labelText: "설계활하중"),
                        ),
                        TextFormField(
                          initialValue: widget.bridge.passingLoad,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _con.bridge.passingLoad = input,
                          validator: (input) =>
                              input.isEmpty ? '허용통행하중을 입력하세요' : null,
                          decoration: InputDecoration(labelText: "허용통행하중"),
                        ),
                        */
                        TextFormField(
                          initialValue: widget.bridge.managementAgency,
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                              _con.bridge.managementAgency = input,
                          validator: (input) =>
                              input.isEmpty ? '관리기관명을 입력하세요' : null,
                          decoration: InputDecoration(labelText: "관리기관명"),
                        ),
                        Container(height: 15),
                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text(
                              widget.bridge.id == null ? "등록하기" : "수정하기",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blueGrey[800],
                            onPressed: () {
                              if (widget.bridge.id == null) {
                                _con.register();
                              } else {
                                _con.bridge.id = widget.bridge.id;
                                _con.update();
                              }
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text(
                              "취소",
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                            color: Colors.transparent,
                            onPressed: () {
                              // Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushReplacementNamed('/BridgeManagePage');
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
