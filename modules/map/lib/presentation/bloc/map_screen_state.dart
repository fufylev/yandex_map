// part of 'map_screen_bloc.dart';
//
// abstract class MapScreenState with DefState<MapScreenState> implements Built<MapScreenState, MapScreenStateBuilder> {
//   MapScreenState._();
//
//   bool get showVenueDetails;
//
//   bool get isLocationServicePending;
//
//   bool get isLocationServiceEnabled;
//
//   bool get isLocationPermissionGranted;
//
//   bool get isMapKeyInitialized;
//
//   MapScreenState setShowVenueDetails(bool value) => rebuild((b) => b..showVenueDetails = value);
//
//   String get searchTextFieldValue;
//
//   MapScreenState setSearchTextFieldValue(String value) => rebuild((b) => b..searchTextFieldValue = value);
//
//   List<PlaceEntity> get places;
//
//   PlaceEntity? get selectedPlace;
//
//   mapkit.MapObject? get selectedMapObject;
//
//   double get zoom;
//
//   LatLng? get gpsPosition;
//
//   MapScreenState setPlaces(List<PlaceEntity> list) => rebuild((b) => b..places = list);
//
//   MapScreenState setSelectedPlace(PlaceEntity? value) => rebuild((b) => b..selectedPlace = value);
//
//   MapScreenState setSelectedMapObject(mapkit.MapObject? value) => rebuild((b) => b..selectedMapObject = value);
//
//   MapScreenState setZoom(double value) => rebuild((b) => b..zoom = value);
//
//   MapScreenState setGpsPosition(LatLng position) => rebuild((b) => b..gpsPosition = position);
//
//   MapScreenState setIsLocationServiceEnabled(bool value) => rebuild((b) => b..isLocationServiceEnabled = value);
//
//   MapScreenState setIsLocationPermissionGranted(bool value) => rebuild((b) => b..isLocationPermissionGranted = value);
//
//   MapScreenState setIsLocationServicePending(bool value) => rebuild((b) => b..isLocationServicePending = value);
//
//   MapScreenState setIsMapKeyInitialized(bool value) => rebuild((b) => b..isMapKeyInitialized = value);
//
//   factory MapScreenState([Function(MapScreenStateBuilder b) updates]) = _$MapScreenState;
//
//   factory MapScreenState.initial() {
//     return MapScreenState((b) => b
//       ..isLoading = false
//       ..showVenueDetails = false
//       ..isLocationServiceEnabled = false
//       ..isLocationPermissionGranted = false
//       ..isLocationServicePending = false
//       ..isMapKeyInitialized = false
//       ..places = []
//       ..zoom = 14.0
//       ..gpsPosition = null
//       ..selectedMapObject = null
//       ..selectedPlace = null
//       ..searchTextFieldValue = '');
//   }
// }
