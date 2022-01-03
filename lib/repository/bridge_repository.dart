import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:sensor_viewer/model/bridge_favorite.dart';
import 'package:sensor_viewer/model/bridge_info.dart';
import '../model/bridge.dart';
import '../helper/helper.dart';
import '../repository/user_repository.dart';

Future<Stream<Bridge>> getBridges(Bridge bridge) async {
  Uri uri = Helper.getUri('api/bridges');
  Map<String, dynamic> _queryParams = {};
  if (bridge.latitude != null && bridge.longitude != null) {
    // _queryParams['myLon'] = bridge.longitude.toString();
    // _queryParams['myLat'] = bridge.latitude.toString();
    // _queryParams['areaLon'] = bridge.longitude.toString();
    // _queryParams['areaLat'] = bridge.latitude.toString();
    _queryParams['latitude'] = bridge.latitude;
    _queryParams['longitude'] = bridge.longitude;
  }

  // 검색
  // _queryParams['search'] = '잠실대교';
  // _queryParams['searchFields'] = 'name:like';

  if (bridge.inspectionResult != null) {
    _queryParams['search'] = "inspection_result:" + bridge.inspectionResult;
  }
  _queryParams['api_token'] = currentUser.value.apiToken;
  _queryParams['limit'] = "20";
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Bridge.fromJSON(data);
    });
  } catch (e) {
    // print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Bridge.fromJSON({}));
  }
}

Future<Stream<BridgeFavorite>> getBridgeFavorites(Bridge bridge) async {
  Uri uri = Helper.getUri('api/bridges/favorite');
  Map<String, dynamic> _queryParams = {};
  _queryParams['search'] = "user_id:" + currentUser.value.id;
  _queryParams['with'] = "bridge";
  _queryParams['limit'] = "100";
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return BridgeFavorite.fromJSON(data);
    });
  } catch (e) {
    // print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new BridgeFavorite.fromJSON({}));
  }
}

Future<Stream<BridgeInfo>> getBridgeInfos(Bridge bridge, bool list) async {
  Uri uri = Helper.getUri('api/bridges/info');
  Map<String, dynamic> _queryParams = {};
  if (list) {
    _queryParams['list'] = "1";
  }
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return BridgeInfo.fromJSON(data);
    });
  } catch (e) {
    // print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new BridgeInfo.fromJSON({}));
  }
}

Future<Stream<Bridge>> getBridge({String id}) async {
  Uri uri = Helper.getUri('api/bridges/$id');
  Map<String, dynamic> _queryParams = {};
  // _queryParams['date'] = date;
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .map((data) => Bridge.fromJSON(data));
  } catch (e) {
    // print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Bridge.fromJSON({}));
  }
}

Future<Stream<BridgeInfo>> getBridgeInfo({String id, String date}) async {
  Uri uri = Helper.getUri('api/bridges/info/$id');
  Map<String, dynamic> _queryParams = {};
  _queryParams['date'] = date;
  _queryParams['with'] = 'bridge';
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return BridgeInfo.fromJSON(data);
    });
  } catch (e) {
    // print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new BridgeInfo.fromJSON({}));
  }
}

Future<Bridge> register(Bridge bridge) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}bridges?$_apiToken';
  // print(json.encode(bridge.toMap()));
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(bridge.toMap()),
  );
  if (response.statusCode == 200) {
    print('ok');
  } else {
    throw new Exception(response.body);
  }
  return Bridge.fromJSON(json.decode(response.body)['data']);
}

Future<Bridge> update(Bridge bridge) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}bridges/setting/${bridge.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.put(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(bridge.toMap()),
  );
  if (response.statusCode == 200) {
    print('ok');
  } else {
    throw new Exception(response.body);
  }
  return Bridge.fromJSON(json.decode(response.body)['data']);
}

Future<Bridge> updateFavorite(Bridge bridge) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}bridges/updateFavorite/${bridge.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.put(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(bridge.toMap()),
  );
  if (response.statusCode == 200) {
    print('ok');
  } else {
    throw new Exception(response.body);
  }
  return Bridge.fromJSON(json.decode(response.body)['data']);
}

Future<Bridge> delete(Bridge bridge) async {
  if (bridge.id == null) {
    return new Bridge();
  }
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}bridges/${bridge.id}?$_apiToken';
  try {
    final client = new http.Client();
    final response = await client.delete(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    return Bridge.fromJSON(json.decode(response.body)['data']);
  } catch (e) {
    // print(CustomTrace(StackTrace.current, message: url).toString());
    return Bridge.fromJSON({});
  }
}
