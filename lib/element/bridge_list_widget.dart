import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sensor_viewer/helper/Helper.dart';
import 'package:sensor_viewer/model/bridge.dart';
import '../widget/my_text.dart';

class BridgeListWidget {
  List<Bridge> briges = <Bridge>[];
  List itemsTile = <ItemTile>[];

  BridgeListWidget(this.briges, onItemClick) {
    for (var i = 0; i < briges.length; i++) {
      itemsTile
          .add(ItemTile(index: i, object: briges[i], onClick: onItemClick));
    }
  }

  Widget getView() {
    return GridView.count(
      scrollDirection: Axis.vertical,
      childAspectRatio: 0.8,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      padding: EdgeInsets.all(3),
      crossAxisCount: 2,
      children: itemsTile,
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final Bridge object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key key,
    @required this.index,
    @required this.object,
    @required this.onClick,
  })  : assert(index != null),
        assert(object != null),
        assert(onClick != null),
        super(key: key);

  void onItemClick(Bridge obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    // String title = object.image;
    return Container(
      child: GestureDetector(
        onTap: () {
          onItemClick(object);
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                // height: 80.0,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(object.image.thumb),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              // color: Colors.blueGrey[800],
              color: Helper.status(object.inspectionResult),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(object.name,
                            style: MyText.subhead(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Container(height: 2),
                        // Text(object.brief,
                        //     style: MyText.caption(context)
                        //         .copyWith(color: Colors.white)),
                        Text('최대가속도 : ${object.acceleration} mg',
                            style: MyText.caption(context)
                                .copyWith(color: Colors.white)),
                        Text('최대변위 : ${object.displacement} mm',
                            style: MyText.caption(context)
                                .copyWith(color: Colors.white)),
                        Text('센서상태 : ${object.sensorText}',
                            style: MyText.caption(context)
                                .copyWith(color: Colors.white)),
                      ],
                    ),
                  ),
                  // Icon(Icons.star_border, color: Colors.white)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
