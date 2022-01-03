import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/bridge_info.dart';
import '../model/bridge.dart';
import '../widget/my_text.dart';

class BridgeSearchWidget {
  List items = <BridgeInfo>[];
  List itemsTile = <ItemTile>[];

  BridgeSearchWidget(this.items) {
    for (var i = 0; i < items.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items[i]));
    }
  }

  Widget getView() {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => itemsTile[index],
        itemCount: itemsTile.length,
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final BridgeInfo object;
  final int index;

  const ItemTile({
    Key key,
    @required this.index,
    @required this.object,
  })  : assert(index != null),
        assert(object != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Container(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: object.bridge.image.thumb,
            ),
          )),
          key: PageStorageKey<int>(index),
          title: Text(object.bridge.name,
              style: MyText.medium(context).copyWith(color: Colors.grey[800])),
          subtitle: Text('${object.bridge.address}',
              style: TextStyle(color: Colors.grey[600])),
          onTap: () {
            Navigator.of(context)
                .pushNamed('/MapBrowsePage', arguments: object.bridge);
          },
        ),
      ],
    );
  }
}
