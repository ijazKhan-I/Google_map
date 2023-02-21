
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  void initState() {
    super.initState();
    SetBound();
    markersAdd();
  }
  final Completer<GoogleMapController> _controller = Completer();
  late   List<Marker>  _marker=[];
 late List <LatLng> _boundesList=[];
   List<LatLng> CordList=[
     LatLng(30.019563680871943, -70.9735170379281),
   LatLng(27.766540713724982, 80.90888652950525),
   LatLng(30.019563680871943, 75.9735170379281),
   LatLng(40.766540713724982, 71.90888652950525),
   LatLng(10.019563680871943, 70.9735170379281),
   LatLng(35.766540713724982, 80.90888652950525),
   LatLng(60.019563680871943, 72.9735170379281),
   LatLng(30.42796133580664, 75.885749655962),
   LatLng(8.019563680871943, 70.9735170379281),
   LatLng(70.766540713724982, 80.90888652950525),
   LatLng(34.019563680871943, 78.9735170379281),
   LatLng(40.766540713724982, 71.90888652950525),
   LatLng(10.019563680871943, 70.9735170379281),
   LatLng(33.766540713724982, 80.90888652950525),
   LatLng(5.019563680871943, 72.9735170379281),
   LatLng(2.766540713724982, 40.90888652950525),
   LatLng(55.28401022027341, 92.02553652226926),
   LatLng(57.84401064167034, -90.20597018301487),
   LatLng(57.84401064167034, 89.4956709444523),
   ];
   final LatLng _center=const LatLng(30.42796133580664, 75.885749655962);

  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(
      title: const Text("Google map"),

    ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_marker),

        onCameraMove: (CameraPosition camerapsition)  {

          if(camerapsition.zoom>=.0){
            _marker.add(const Marker(markerId: MarkerId("Zoom detection"),
            position: LatLng(30.34554545,75.938934),
              infoWindow: InfoWindow(
                title: "Zoom Detection"
              ),

            ));

            setState(() {});
          }


        },
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _center,

        ),

      ),


    );
  }
  void markersAdd(){
    for(int i=0;i<_boundesList.length;i++){
      _marker.add(Marker(markerId: MarkerId("$i"),
          position: _boundesList[i],
          infoWindow: const InfoWindow(
            title: "",
          )
      )
      );
    }
  }


  Future<LatLngBounds> _getVisibleRegion() async {
    final GoogleMapController controller = await _controller.future;
    final LatLngBounds bounds = await controller.getVisibleRegion();
    print("${bounds}");
    return bounds;
  }
  void SetBound() async {

    LatLngBounds bounds = await _getVisibleRegion();
    print("Bounds${bounds}");
    for(int i=0;i<CordList.length;i++){
      if(bounds.contains(CordList[i])){
        print("this");
        _boundesList.add(CordList[i]);
      }
    }
  }

  }

