// import 'dart:async';
//
// import 'package:app_events/domain/entity/app_event.dart';
// import 'package:app_events/domain/use_case/add_app_event_use_case.dart';
// import 'package:app_events/domain/use_case/get_app_events_stream_use_case.dart';
// import 'package:built_value/built_value.dart';
// import 'package:common/common.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ieye_ble_service/ble_beacon_service.dart';
// import 'package:map/domain/entities/lat_lng.dart';
// import 'package:map/domain/entities/screen_corner_coordinates.dart';
// import 'package:map/domain/usecases/init_map_use_case.dart';
// import 'package:map/navigation/navigation.dart';
// import 'package:permissions_location_service_handler/domain/entities/coordinate.dart';
// import 'package:permissions_location_service_handler/service/location_service.dart';
// import 'package:place_core/place_core.dart';
// import 'package:yandex_maps_mapkit/mapkit.dart' as mapkit;
//
// ///
// part 'map_screen_bloc.g.dart';
// part 'map_screen_event.dart';
// part 'map_screen_state.dart';
//
// class MapScreenBloc extends BaseBloc<MapScreenEvent, MapScreenState> {
//   final GetPlacesByCoordinatesUseCase getPlacesByCoordinatesUseCase;
//   final ScannerService scannerService;
//   final GetPlaceByIdUseCase getPlaceByIdUseCase;
//   final MapNavigator navigator;
//   final LocationServiceHandler locationService;
//   final GetAppEventsStreamUseCase getAppEventsStreamUseCase;
//   final AddAppEventUseCase addAppEventUseCase;
//   final InitMapUseCase initMapUseCase;
//
//   MapScreenBloc({
//     required this.scannerService,
//     required this.getPlacesByCoordinatesUseCase,
//     required this.getPlaceByIdUseCase,
//     required this.navigator,
//     required this.locationService,
//     required this.getAppEventsStreamUseCase,
//     required this.addAppEventUseCase,
//     required this.initMapUseCase,
//     required ErrorHandler errorHandler,
//   }) : super(MapScreenState.initial(), errorHandler: errorHandler) {
//     on<ShowPlaceDetailsScreenEvent>(_onShowVenueDetailsScreenEvent, transformer: sequential());
//     on<OnClearMapInputChangeEvent>(_onClearMapInputChangeEvent, transformer: sequential());
//     on<OnMapInputChangeEvent>(_onMapInputChangeEvent, transformer: sequential());
//     on<OnMapInitEvent>(_onMapInitEvent, transformer: sequential());
//     on<OnInitEvent>(_onInitEvent, transformer: sequential());
//     on<OnSendCoordinatesEvent>(_onSendCoordinatesEvent, transformer: sequential());
//     on<NavigateToPlaceDetailsEvent>(_onNavigateToPlaceDetailsEvent, transformer: sequential());
//     on<GetCurrentPositionEvent>(_onGetCurrentPositionEvent, transformer: sequential());
//     on<GetPlaceByIdEvent>(_onGetPlaceByIdEvent, transformer: sequential());
//     on<OnSetZoomEvent>(_onSetZoomEvent, transformer: sequential());
//     on<OnSetSelectedPlaceMarkEvent>(_onPlaceClickEvent, transformer: sequential());
//     on<UpdateSelectedPlaceEvent>(_onUpdateSelectedPlaceEvent, transformer: sequential());
//     on<OnThemeChangeEvent>(_onThemeChangeEvent, transformer: sequential());
//     on<OnInitMapEvent>(_onInitMapEvent, transformer: sequential());
//
//     _listenLocationService();
//     _listenMap();
//   }
//
//   StreamSubscription<bool>? _locationEnabledSubscription;
//   StreamSubscription<AppEvent>? _eventSubscription;
//   Map<String, PlaceEntity> placesMap = {};
//   List<PlaceEntity> list = [];
//
//   @override
//   Future<void> close() async {
//     _locationEnabledSubscription?.cancel();
//     _eventSubscription?.cancel();
//     return super.close();
//   }
//
//   void _listenMap() async {
//     processSyncUseCase<Stream<AppEvent>>(
//       getAppEventsStreamUseCase.call(EmptyUsecaseParams()),
//       onSuccess: (stream) {
//         _eventSubscription = stream.listen((AppEvent event) {
//           if (event is MoveMapToCoordinatesEvent) {
//             final place = PlaceEntity.coordinate(event.placeId, event.lat, event.lng);
//             if (!placesMap.containsKey(place.id)) {
//               addNews(MoveMapToCoordinates(lat: event.lat, lng: event.lng, zoom: state.zoom));
//               addIfNotClosed(GetPlaceByIdEvent(placeId: event.placeId));
//             } else {
//               addIfNotClosed(UpdateSelectedPlaceEvent(place: place));
//             }
//           } else if (event is OnBottomNavBarTap) {
//             addNews(OnBottomNavBarTapEvent(event.tabIndex));
//           }
//         });
//       },
//     );
//   }
//
//   void _listenLocationService() {
//     _locationEnabledSubscription = locationService.listenIsPermissionGranted().listen((bool value) {
//       if (!state.isLocationServicePending && state.isLocationPermissionGranted != value) {
//         addIfNotClosed(OnMapInitEvent());
//       }
//     });
//   }
//
//   Future<void> _onThemeChangeEvent(OnThemeChangeEvent event, Emitter<MapScreenState> emit) async {
//     addNews(ThemeChangeEvent(state.places));
//   }
//
//   Future<void> _onInitMapEvent(OnInitMapEvent event, Emitter<MapScreenState> emit) async {
//     await processUseCase(
//       () => initMapUseCase(EmptyUsecaseParams()),
//       onSuccess: (_) {
//         emitIfNotClosed(emit, state.setIsMapKeyInitialized(true));
//       },
//     );
//   }
//
//   Future<void> _onUpdateSelectedPlaceEvent(UpdateSelectedPlaceEvent event, Emitter<MapScreenState> emit) async {
//     emitIfNotClosed(emit, state.setSelectedPlace(event.place));
//     addNews(AddPlaces(places: list, updateAll: true));
//     addNews(MoveMapToCoordinates(lat: event.place.latitude, lng: event.place.longitude, zoom: state.zoom));
//   }
//
//   Future<void> _onPlaceClickEvent(OnSetSelectedPlaceMarkEvent event, Emitter<MapScreenState> emit) async {
//     final previouslySelectedMapObject = state.selectedMapObject;
//     emitIfNotClosed(emit, state.setSelectedMapObject(event.mapObject));
//     if (previouslySelectedMapObject == null) {
//       addNews(UpdatePlaceMarks(
//         previouslySelectedMapObject: previouslySelectedMapObject,
//         selectedMapObject: event.mapObject,
//       ));
//     } else {
//       final previouslySelectedMapData = previouslySelectedMapObject.userData;
//       final currentSelectedMapData = event.mapObject.userData;
//       if (previouslySelectedMapData is PlaceEntity && currentSelectedMapData is PlaceEntity) {
//         if (previouslySelectedMapData.id != currentSelectedMapData.id) {
//           addNews(UpdatePlaceMarks(
//             previouslySelectedMapObject: previouslySelectedMapObject,
//             selectedMapObject: event.mapObject,
//           ));
//         }
//       }
//     }
//   }
//
//   Future<void> _onGetPlaceByIdEvent(GetPlaceByIdEvent event, Emitter<MapScreenState> emit) async {
//     emitIfNotClosed(emit, state.setLoading(true));
//     await processUseCase<PlaceEntity>(
//       () => getPlaceByIdUseCase(event.placeId),
//       onSuccess: (PlaceEntity place) {
//         if (!placesMap.containsKey(place.id)) {
//           list.add(place);
//           placesMap.putIfAbsent(place.id, () => place);
//           emitIfNotClosed(emit, state.setPlaces(list).setSelectedPlace(place).setLoading(false));
//         }
//         addNews(AddPlaces(places: list, updateAll: true));
//       },
//       onError: (e) {
//         emitIfNotClosed(emit, state.setLoading(false));
//       },
//     );
//   }
//
//   Future<void> _onGetCurrentPositionEvent(GetCurrentPositionEvent evenxt, Emitter<MapScreenState> emit) async {
//     emitIfNotClosed(emit, state.setIsLocationServicePending(true));
//
//     final isLocationServiceEnabled = locationService.serviceEnabled;
//     bool isLocationPermissionGranted = locationService.isPermissionGranted;
//
//     if (!isLocationServiceEnabled || !isLocationPermissionGranted) {
//       isLocationPermissionGranted = await locationService.requestLocationPermission();
//       if (isLocationPermissionGranted) {
//         final Coordinate location = await locationService.getLocationData();
//         addNews(SetLocationData(location: location, zoom: state.zoom));
//       } else {
//         // TODO - показать ботом щит что нужен пермишен
//       }
//     } else {
//       final Coordinate location = await locationService.getLocationData();
//       addNews(SetLocationData(location: location, zoom: state.zoom));
//     }
//
//     emitIfNotClosed(
//         emit,
//         state
//             .setIsLocationServicePending(false)
//             .setIsLocationServiceEnabled(isLocationServiceEnabled)
//             .setIsLocationPermissionGranted(isLocationPermissionGranted));
//   }
//
//   Future<void> _onSendCoordinatesEvent(
//     OnSendCoordinatesEvent event,
//     Emitter<MapScreenState> emit,
//   ) async {
//     processSyncUseCase(addAppEventUseCase(MapStartSearchingProcess()), onSuccess: (_) {});
//     emitIfNotClosed(emit, state.setLoading(true));
//     final coordinates = event.coordinates;
//
//     await processUseCase<List<PlaceEntity>>(
//       () => getPlacesByCoordinatesUseCase(
//         SearchPlacesByCoordinatesParams(
//           leftTopLatitude: coordinates.topLeft.latitude,
//           leftTopLongitude: coordinates.topLeft.longitude,
//           bottomRightLatitude: coordinates.bottomRight.latitude,
//           bottomRightLongitude: coordinates.bottomRight.longitude,
//           zoom: event.zoom,
//         ),
//       ),
//       onSuccess: (List<PlaceEntity> result) {
//         if (result.isNotEmpty) {
//           bool hasNew = false;
//           List<PlaceEntity> newList = [];
//           for (PlaceEntity place in result) {
//             if (!placesMap.containsKey(place.id)) {
//               list.add(place);
//               newList.add(place);
//               placesMap.putIfAbsent(place.id, () => place);
//               hasNew = true;
//             }
//           }
//           if (hasNew) {
//             emitIfNotClosed(emit, state.setPlaces(list));
//             addNews(AddPlaces(places: newList));
//           }
//         }
//       },
//     );
//
//     emitIfNotClosed(emit, state.setLoading(false));
//     processSyncUseCase(addAppEventUseCase(MapEndSearchingProcess()), onSuccess: (_) {});
//   }
//
//   Future<void> _onInitEvent(OnInitEvent event, Emitter<MapScreenState> emit) async {}
//
//   Future<void> _onMapInitEvent(OnMapInitEvent event, Emitter<MapScreenState> emit) async {
//     emitIfNotClosed(emit, state.setIsLocationServicePending(true));
//     await locationService.setLocationStatus();
//     final isLocationServiceEnabled = locationService.serviceEnabled;
//     final isLocationPermissionGranted = locationService.isPermissionGranted;
//
//     emitIfNotClosed(
//         emit,
//         state
//             .setIsLocationServiceEnabled(isLocationServiceEnabled)
//             .setIsLocationPermissionGranted(isLocationPermissionGranted));
//
//     emitIfNotClosed(emit, state.setIsLocationServicePending(false));
//   }
//
//   Future<void> _onShowVenueDetailsScreenEvent(ShowPlaceDetailsScreenEvent event, Emitter<MapScreenState> emit) async {
//     addNews(ShowPlaceDetailsScreen(place: event.place));
//   }
//
//   Future<void> _onClearMapInputChangeEvent(OnClearMapInputChangeEvent event, Emitter<MapScreenState> emit) async {
//     emitIfNotClosed(emit, state.setSearchTextFieldValue(''));
//   }
//
//   Future<void> _onMapInputChangeEvent(OnMapInputChangeEvent event, Emitter<MapScreenState> emit) async {
//     emitIfNotClosed(emit, state.setSearchTextFieldValue(event.value));
//   }
//
//   Future<void> _onSetZoomEvent(OnSetZoomEvent event, Emitter<MapScreenState> emit) async {
//     emitIfNotClosed(emit, state.setZoom(event.zoom));
//   }
//
//   Future<void> _onNavigateToPlaceDetailsEvent(NavigateToPlaceDetailsEvent event, Emitter<MapScreenState> emit) async {
//     final placeId = event.placeId;
//     final place = state.places.where((e) => e.id == placeId).toList().firstOrNull;
//     if (place != null) {
//       navigator.navigateToPlaceDetails(placeName: place.name, placeId: place.id);
//     }
//   }
// }
//
// class ThemeChangeEvent extends BlocNews {
//   final List<PlaceEntity> places;
//
//   ThemeChangeEvent(this.places);
// }
//
// class MoveMapToCoordinates extends BlocNews {
//   final double lat;
//   final double lng;
//   final double zoom;
//
//   MoveMapToCoordinates({
//     required this.lat,
//     required this.lng,
//     required this.zoom,
//   });
// }
//
// class OnBottomNavBarTapEvent extends BlocNews {
//   final int tabIndex;
//
//   OnBottomNavBarTapEvent(this.tabIndex);
// }
//
// class SetLocationData extends BlocNews {
//   final Coordinate location;
//   final double zoom;
//
//   SetLocationData({
//     required this.location,
//     required this.zoom,
//   });
// }
//
// class AddPlaces extends BlocNews {
//   final List<PlaceEntity> places;
//   final bool updateAll;
//
//   AddPlaces({required this.places, this.updateAll = false});
// }
//
// class UpdatePlaceMarks extends BlocNews {
//   final mapkit.MapObject selectedMapObject;
//   final mapkit.MapObject? previouslySelectedMapObject;
//
//   UpdatePlaceMarks({
//     required this.selectedMapObject,
//     this.previouslySelectedMapObject,
//   });
// }
//
// class ShowPlaceDetailsScreen extends BlocNews {
//   final PlaceEntity place;
//
//   ShowPlaceDetailsScreen({required this.place});
// }
