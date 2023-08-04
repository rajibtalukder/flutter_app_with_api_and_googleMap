
import 'package:elm/mvc/controller/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../constant/color.dart';
import '../../../constant/value.dart';

class SiteMap extends StatefulWidget {
  const SiteMap({Key? key}) : super(key: key);

  @override
  State<SiteMap> createState() => _SiteMapState();
}

class _SiteMapState extends State<SiteMap> {
  var _selectIndex= -1;

  MapController _mapController =Get.put(MapController());

  // final Completer<GoogleMapController> _controller =
  // Completer<GoogleMapController>();

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 1; i < _mapController.latlng.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _mapController.latlng[i],
          infoWindow: InfoWindow(
            title: "Really cool place",
            snippet: "5 star rating",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      _polyline.add(Polyline(
        polylineId: PolylineId('1'),
        points: _mapController.latlng,
        color: Colors.orange,
        width: 3,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: primaryColor,
      padding:
          EdgeInsets.symmetric(horizontal: width / 17, vertical: height / 18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                elevation: 0,
                onPressed: () {
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'BACK',
                      style: TextStyle(color: white),
                    )
                  ],
                ),
              ),
              Image.asset(
                'assets/logoo.png',
                height: 40,
                fit: BoxFit.cover,
                color: white,
              ),
            ],
          ),
          Expanded(
            child: Card(
              color: secondaryColor,
              elevation: 5,
              margin: EdgeInsets.symmetric(
                  vertical: height / 40, horizontal: width / 42),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(height / 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Site Map',
                            style: TextStyle(
                                color: white,
                                fontSize: fontBig,
                                fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            for (int i = 0; i < 8; i++)
                              Row(
                                children: [
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    height: height / 20,
                                    width: width / 30,
                                    child: MaterialButton(
                                      elevation: 0,
                                      color: _selectIndex==i?alternate: white,
                                      onPressed: ()async {
                                        _mapController.updateSelectMapIndex(i);
                                        _mapController.changePosition();
                                        setState(() {
                                          _selectIndex=i;
                                        });
                                        },
                                      // height: 20,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Text(
                                        i.toString(),
                                        style: TextStyle(color : primaryColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: height / 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'PROJECTS ON THIS FLOOR',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 14.0),
                            ),
                            SizedBox(height: height / 20),
                            for (int i = 0; i < _mapController.places.length; i++)
                               GestureDetector(
                                 onTap:()async{
                                   _mapController.updateSelectMapIndex(i);
                                   _mapController.changePosition();
                                   setState(() {
                                     _selectIndex= i;
                                   });
                                 },
                                 child: Text("${_mapController.places[i]}\n",
                                    style: TextStyle(
                                        color: _selectIndex==i?alternate:Colors.white70, fontSize: fontVerySmall)),
                               ),
                          ],
                        ),
                        Container(
                            height: height / 2,
                            width: width / 2,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(width: 2, color: white)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: GetBuilder<MapController>(
                                init: MapController(),
                                builder:(controller)=> GoogleMap(
                                    markers: _markers,
                                    mapType: MapType.hybrid,
                                    initialCameraPosition: controller.initialCameraPosition.value,
                                    myLocationEnabled: true,
                                    polylines: _polyline,
                                    onMapCreated: controller.onMapCreated,
                                  ),
                              ),

                            ),
                            // child: GestureDetector(
                            //   onTap: (){
                            //     Get.to(()=> MapSample());
                            //   },
                            //     child: Image.asset("assets/Map Icon.png")),
                            ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
