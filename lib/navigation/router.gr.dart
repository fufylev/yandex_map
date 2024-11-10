// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:home/navigation/navigation_module.dart' as _i3;
import 'package:map/navigation/navigation_module.dart' as _i5;
import 'package:map_test/main.dart' as _i1;
import 'package:profile/navigation/navigation_module.dart' as _i6;
import 'package:search/navigation/navigation_module.dart' as _i4;

abstract class $AppRouter extends _i2.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    ..._i3.HomeModule().pagesMap,
    ..._i4.SearchModule().pagesMap,
    ..._i5.MapModule().pagesMap,
    ..._i6.ProfileModule().pagesMap,
  };
}

/// generated route for
/// [_i1.MainScreen]
class MainRoute extends _i2.PageRouteInfo<void> {
  const MainRoute({List<_i2.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}
