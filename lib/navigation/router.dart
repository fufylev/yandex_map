import 'package:auto_route/auto_route.dart';
import 'package:home/navigation/navigation_module.dart';
import 'package:home/navigation/navigation_module.gm.dart';
import 'package:map/navigation/navigation_module.dart';
import 'package:map/navigation/navigation_module.gm.dart';
import 'package:map_test/navigation/router.gr.dart';
import 'package:profile/navigation/navigation_module.dart';
import 'package:profile/navigation/navigation_module.gm.dart';
import 'package:search/navigation/navigation_module.dart';
import 'package:search/navigation/navigation_module.gm.dart';

const routerModules = [
  HomeModule,
  SearchModule,
  MapModule,
  ProfileModule,
];

final routerRoutes = [
  AutoRoute(
    page: MainRoute.page,
    path: '/MainRoute',
    children: [
      AutoRoute(page: HomeRoute.page, path: 'HomeRoute'),
      AutoRoute(page: SearchRoute.page, path: 'SearchRoute'),
      AutoRoute(page: MapRoute.page, path: 'MapRoute'),
      AutoRoute(page: ProfileRoute.page, path: 'ProfileRoute'),
    ],
    initial: true,
  ),
];

@AutoRouterConfig(modules: routerModules, replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => routerRoutes;
}
