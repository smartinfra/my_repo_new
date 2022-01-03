import 'package:flutter/material.dart';
import '../widget/my_text.dart';

class ListModuleWidget extends StatelessWidget {
  final String title;
  final String desc;
  const ListModuleWidget({Key key, this.title, this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(title),
        ),
        Expanded(
          flex: 2,
          child: Text(desc,
              style: MyText.body1(context).copyWith(
                  fontWeight: FontWeight.bold, color: Colors.green[600])),
        ),
      ],
    );
  }
}
