import 'package:elm/mvc/controller/error_controller.dart';
//import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController with ErrorController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentPosition();
  }

  void getCurrentPosition() async {
    // LocationPermission permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied ||
    //     permission == LocationPermission.deniedForever) {
    //  print("Permission not given");
    //  LocationPermission asked = await Geolocator.requestPermission();
    // } else {
    //  Position currentPosition = await Geolocator.getCurrentPosition(
    //      desiredAccuracy: LocationAccuracy.best);
    //  CameraPosition(
    //   target: LatLng(currentPosition.longitude, currentPosition.latitude),
    //   zoom: 15,
    //  );
    // }
  }

  Rx selectMap = 0.obs;

  late Rx<CameraPosition> initialCameraPosition = CameraPosition(
    target: latlng[selectMap.value],
    zoom: 14.4746,
  ).obs;

  late GoogleMapController mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void changePosition() {
    final newPosition = CameraPosition(
      target: latlng[selectMap.value],
      zoom: 14.4746,
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  RxList<LatLng> latlng = [
    LatLng(51.5074, -0.1278),
    LatLng(51.5072, -0.1276),
    LatLng(51.5010, -0.1416),
    LatLng(51.5080, -0.0784),
    LatLng(51.5299, -0.1277),
    LatLng(51.5033, -0.1195),
    LatLng(51.5077, -0.0701),
    LatLng(51.5286, -0.1018),
  ].obs;

  RxList<String> places = [
    '•  Trafalgar Square',
    '•  Nelson\'s Column',
    '•  London Eye',
    '•  The Gherkin',
    '•  Camden Market',
    '•  Houses of Parliament',
    '•  Tower Bridge',
    '•  British Museum',
  ].obs;

  void updateSelectMapIndex(int x) {
    selectMap.value = x;
  }
}
