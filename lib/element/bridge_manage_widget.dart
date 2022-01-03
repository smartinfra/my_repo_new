import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sensor_viewer/element/list_element_widget.dart';
import '../data/img.dart';
import '../data/my_colors.dart';
import '../data/my_strings.dart';
import '../model/bridge.dart';
import '../widget/my_text.dart';
import 'package:toast/toast.dart';
import '../repository/bridge_repository.dart' as repository;

class BridgeManageWidget {
  List items = <Bridge>[];
  List itemsTile = <ItemTile>[];

  BridgeManageWidget(this.items, onDeleteClick) {
    for (var i = 0; i < items.length; i++) {
      itemsTile
          .add(ItemTile(index: i, object: items[i], onDelete: onDeleteClick));
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
  final Bridge object;
  final int index;
  final Function onDelete;

  const ItemTile({
    Key key,
    @required this.index,
    @required this.object,
    @required this.onDelete,
  })  : assert(index != null),
        assert(object != null),
        assert(onDelete != null),
        super(key: key);

  void onDeleteClick(context, Bridge obj) {
    onDelete(context, obj);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          leading: Container(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: object.image.thumb,
            ),
          )),
          key: PageStorageKey<int>(index),
          title: Text(object.name,
              style: MyText.medium(context).copyWith(color: Colors.grey[800])),
          subtitle:
              Text('${object.createdAt}', style: TextStyle(color: Colors.grey)),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              color: MyColors.grey_5,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text('주소'),
                      ),
                      Expanded(
                        flex: 3,
                        child: Wrap(
                          spacing: 4.0, // gap between adjacent chips
                          runSpacing: 4.0, // gap between lines
                          direction:
                              Axis.horizontal, // main axis (rows or columns)
                          children: [
                            object.address == '' || object.address == null
                                ? Text('주소를 등록해 주세요',
                                    style: MyText.body1(context).copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey[600]))
                                : Text('${object.address}',
                                    overflow: TextOverflow.fade,
                                    softWrap: true,
                                    maxLines: 2,
                                    style: MyText.body1(context)
                                        .copyWith(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: IconButton(
                                padding: EdgeInsets.all(0.0),
                                icon: Icon(
                                  Icons.edit_location,
                                  size: 24.0,
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/MapPage', arguments: object);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(height: 10),
                  ListElementWidget(
                    title: "상부구조형식",
                    desc: "${object.superstructureType}",
                  ),
                  Container(height: 10),
                  ListElementWidget(
                    title: "교량준공연도",
                    desc: "${object.constructionYear}",
                  ),
                  /*
                  Container(height: 10),
                  ListElementWidget(
                    title: "교량연장",
                    desc: "${object.bridgeExtension}",
                  ),
                  Container(height: 10),
                  ListElementWidget(
                    title: "설계활하중",
                    desc: "${object.designLoad}",
                  ),
                  Container(height: 10),
                  ListElementWidget(
                    title: "허용통행하중",
                    desc: "${object.passingLoad}",
                  ),
                  Container(height: 10),
                  */
                  ListElementWidget(
                    title: "관리기관명",
                    desc: "${object.managementAgency}",
                  ),
                  Container(height: 10),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        child: Text(
                          "수정",
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                        // color: Colors.grey[800],
                        onPressed: () {
                          Navigator.of(context).pushNamed('/BridgeRegisterPage',
                              arguments: object);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "삭제",
                          style: TextStyle(color: Colors.grey),
                        ),
                        // color: Colors.grey[400],
                        onPressed: () {
                          onDelete(context, object);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        Divider(height: 0)
      ],
    );
  }

  static void showToastClicked(BuildContext context, String action) {
    print(action);
    Toast.show(action + " clicked", context);
  }
}
