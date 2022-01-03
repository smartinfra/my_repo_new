import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sensor_viewer/data/img.dart';
import 'package:sensor_viewer/helper/Helper.dart';
import '../model/bridge.dart';
import '../model/bridge_favorite.dart';
import '../widget/my_text.dart';

class BridgeFavoriteWidget {
  List<BridgeFavorite> favorites = <BridgeFavorite>[];
  List itemsTile = <ItemTile>[];

  BridgeFavoriteWidget(this.favorites, onItemClick) {
    for (var i = 0; i < favorites.length; i++) {
      itemsTile
          .add(ItemTile(index: i, object: favorites[i], onClick: onItemClick));
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
  final BridgeFavorite object;
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
          onItemClick(object.bridge);
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
                    image:
                        CachedNetworkImageProvider(object.bridge.image.thumb),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: Container(
            //     decoration: BoxDecoration(
            //         image: DecorationImage(
            //       fit: BoxFit.cover,
            //       image: ExactAssetImage(
            //           Img.get('bridge/' + object.bridge.id + '.jpeg')),
            //     )),
            //   ),
            // ),

            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              // color: Colors.blueGrey[800],
              color: Helper.status(object.bridge.inspectionResult),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(object.bridge.name,
                            style: MyText.subhead(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Container(height: 2),
                        // Text(object.brief,
                        //     style: MyText.caption(context)
                        //         .copyWith(color: Colors.white)),
                        Text('최대가속도 : ${object.bridge.acceleration} mg',
                            style: MyText.caption(context)
                                .copyWith(color: Colors.white)),
                        Text('최대변위 : ${object.bridge.displacement} mm',
                            style: MyText.caption(context)
                                .copyWith(color: Colors.white)),
                        Text('센서상태 : ${object.bridge.sensorText}',
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
