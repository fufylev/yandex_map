import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:home/navigation/navigation_module.gm.dart';
import 'package:map/navigation/navigation_module.gm.dart';
import 'package:map_test/navigation/router.dart';
import 'package:profile/navigation/navigation_module.gm.dart';
import 'package:search/navigation/navigation_module.gm.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init.initMapkit(apiKey: 'fa835f17-c41d-4102-9353-7cd9aad4ad58');

  runApp(MyApp(router: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  const MyApp({super.key, required this.router});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);

        return MediaQuery(
          data: mediaQueryData.copyWith(textScaler: TextScaler.noScaling),
          child: child ?? const SizedBox.shrink(),
        );
      },
      // use l10n library for Internationalizing app
      locale: const Locale('ru'),
      // locale: state.localization,
      localizationsDelegates: const [],

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      /// router
      routerConfig: router.config(),

      ///
      debugShowCheckedModeBanner: false,
    );
  }
}

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        SearchRoute(),
        MapRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Center(child: Icon(Icons.home)),
              backgroundColor: Colors.grey,
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Center(child: Icon(Icons.search)),
              backgroundColor: Colors.grey,
            ),
            BottomNavigationBarItem(
              label: 'Map',
              icon: Center(child: Icon(Icons.map)),
              backgroundColor: Colors.grey,
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Center(child: Icon(Icons.verified_user)),
              backgroundColor: Colors.grey,
            ),
          ],
        );
      },
    );
  }
}
