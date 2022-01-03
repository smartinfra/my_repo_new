import 'package:flutter/material.dart';
import 'model/bridge_info.dart';
import 'page/map_search_page.dart';
import 'page/map_browse_page.dart';
import 'page/bridge_register_page.dart';
import 'page/profile_page.dart';
import 'page/bridge_manage_page.dart';
import 'page/register_page.dart';
import 'model/bridge.dart';
import 'page/bridge_trigger_page.dart';
import 'page/bridge_page.dart';
import 'page/dashboard_page.dart';
import 'page/login_page.dart';
import 'route/about/about_app.dart';
import 'route/menu_route.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/MenuRoute':
        return MaterialPageRoute(builder: (_) => MenuRoute());
      case '/About':
        return MaterialPageRoute(builder: (_) => AboutAppRoute());
      case '/LoginPage':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/RegisterPage':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/DashboardPage':
        return MaterialPageRoute(builder: (_) => DashboardPage());
      case '/BridgePage':
        return MaterialPageRoute(
            builder: (_) => BridgePage(bridge: args as Bridge));
      case '/BridgeTriggerPage':
        return MaterialPageRoute(
            builder: (_) => BridgeTriggerPage(trigger: args as BridgeInfo));
      case '/MapBrowsePage':
        return MaterialPageRoute(
            builder: (_) => MapBrowsePage(bridge: args as Bridge));
      case '/MapSearchPage':
        return MaterialPageRoute(builder: (_) => MapSearchPage());
      case '/ProfilePage':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/BridgeManagePage':
        return MaterialPageRoute(builder: (_) => BridgeManagePage());
      case '/BridgeRegisterPage':
        return MaterialPageRoute(
            builder: (_) => BridgeRegisterPage(bridge: args as Bridge));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: SizedBox(height: 0)));
    }
  }
}
