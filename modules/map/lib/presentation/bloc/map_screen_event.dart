// part of 'map_screen_bloc.dart';
//
// sealed class MapScreenEvent {}
//
// class ShowPlaceDetailsScreenEvent extends MapScreenEvent {
//   ShowPlaceDetailsScreenEvent({required this.place});
//
//   final PlaceEntity place;
// }
//
// class OnClearMapInputChangeEvent extends MapScreenEvent {}
//
// class OnInitMapEvent extends MapScreenEvent {}
//
// class OnThemeChangeEvent extends MapScreenEvent {}
//
// class OnSetZoomEvent extends MapScreenEvent {
//   final double zoom;
//
//   OnSetZoomEvent({required this.zoom});
// }
//
// class OnMapInitEvent extends MapScreenEvent {}
//
// class OnSetSelectedPlaceMarkEvent extends MapScreenEvent {
//   final mapkit.MapObject mapObject;
//
//   OnSetSelectedPlaceMarkEvent({required this.mapObject});
// }
//
// class UpdateSelectedPlaceEvent extends MapScreenEvent {
//   final PlaceEntity place;
//
//   UpdateSelectedPlaceEvent({required this.place});
// }
//
// class OnMapInputChangeEvent extends MapScreenEvent {
//   final String value;
//
//   OnMapInputChangeEvent({required this.value});
// }
//
// class OnInitEvent extends MapScreenEvent {}
//
// class GetCurrentPositionEvent extends MapScreenEvent {}
//
// class OnSendCoordinatesEvent extends MapScreenEvent {
//   final ScreenCornerCoordinates coordinates;
//   final double zoom;
//
//   OnSendCoordinatesEvent({required this.coordinates, required this.zoom});
// }
//
// class NavigateToPlaceDetailsEvent extends MapScreenEvent {
//   final String placeId;
//
//   NavigateToPlaceDetailsEvent({required this.placeId});
// }
//
// class GetPlaceByIdEvent extends MapScreenEvent {
//   final String placeId;
//
//   GetPlaceByIdEvent({required this.placeId});
// }
