import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit/mapkit.dart' as _mapkit;
import 'package:yandex_maps_mapkit/mapkit_factory.dart';
import 'package:yandex_maps_mapkit/yandex_map.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool mapLoaded = false;
  late _mapkit.MapWindow _mapWindow;
  bool _isMapkitActive = false;
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    _startMapkit();
    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        _startMapkit();
      },
      onInactive: () {
        _stopMapkit();
      },
    );
  }

  @override
  void dispose() {
    _stopMapkit();
    _lifecycleListener.dispose();
    super.dispose();
  }

  void _startMapkit() {
    if (!_isMapkitActive) {
      _isMapkitActive = true;
      mapkit.onStart();
    }
  }

  void _stopMapkit() {
    if (_isMapkitActive) {
      _isMapkitActive = false;
      mapkit.onStop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        onMapCreated: (_mapkit.MapWindow window) {
          _mapWindow = window;
          mapLoaded = true;
        },
        platformViewType: PlatformViewType.Hybrid,
      ),
    );
  }
}
