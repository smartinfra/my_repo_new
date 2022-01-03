import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonContactWidget extends StatelessWidget {
  final String contact;
  const ButtonContactWidget({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      child: FlatButton(
        child: Text(
          "분석의뢰",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blueGrey[800],
        onPressed: () {
          // Navigator.of(context).pushNamed('/BridgeTriggerPage');
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  titlePadding: EdgeInsets.fromLTRB(16, 25, 16, 0),
                  title: Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        color: Theme.of(context).hintColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '담당기관 연결하기',
                        style: Theme.of(context).textTheme.body2,
                      )
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Text(
                            contact,
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          child: FlatButton(
                            onPressed: () {
                              launch("tel:$contact");
                            },
                            child: Text(
                              '연결',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              '닫기',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                    SizedBox(height: 10),
                  ],
                );
              });
        },
      ),
    );
  }
}
