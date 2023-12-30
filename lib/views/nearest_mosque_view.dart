// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'dart:async';

import 'package:azkar_app/helpers/background_with_gradient_color.dart';
import 'package:azkar_app/models/my_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class NearestMosqueView extends StatefulWidget {
  const NearestMosqueView({super.key});

  @override
  State<NearestMosqueView> createState() => _NearestMosqueViewState();
}

class _NearestMosqueViewState extends State<NearestMosqueView> {
  String mapTheme = '';
  final Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final model = Provider.of<MyModel>(context, listen: false);
      model.getPermission(context, model.theme);
      model.getLatLong();
      // setMarkerCustomImage();
      model.ps = Geolocator.getPositionStream().listen((Position position) {
        model.changeMarker(position.latitude, position.longitude);
        model.gmc!.animateCamera(CameraUpdate.newLatLng(
            LatLng(position.latitude, position.longitude)));
      });

      DefaultAssetBundle.of(context)
          .loadString('assets/json/dark_mode_style.json')
          .then((value) {
        model.theme == 'Light' ? mapTheme = '[]' : mapTheme = value;
      });
    });
  }

  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MyModel>(context, listen: true);

    return Scaffold(
        body: BackgroundWithGradientColor(
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.05,
            left: 5,
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.circleArrowLeft,
                color: model.theme == 'Light'
                    ? const Color(0XFFF9F9F9)
                    : const Color(0XFFBD874F),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: model.theme == 'Light'
                      ? Colors.brown
                      : Colors.grey.shade900,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              height: MediaQuery.sizeOf(context).height * 0.88,
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: model.theme == 'Light'
                          ? const Color.fromARGB(255, 249, 249, 249)
                          : const Color.fromARGB(255, 60, 50, 40),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  height: MediaQuery.sizeOf(context).height * 0.86,
                  width: MediaQuery.sizeOf(context).width,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    child: SizedBox(
                      // decoration: BoxDecoration(
                      //     color: Colors.green,
                      //     borderRadius: BorderRadius.circular(40)),
                      // height: MediaQuery.sizeOf(context).width * 0.90,
                      // width: MediaQuery.sizeOf(context).width * 0.90,

                      height: MediaQuery.sizeOf(context).height * 0.86,
                      width: double.infinity,
                      child: model.kGooglePlex == null
                          ? Center(
                              child: CircularProgressIndicator(
                              color: model.theme == 'Light'
                                  ? Colors.brown
                                  : const Color.fromARGB(255, 226, 146, 67),
                            ))
                          : GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: model.kGooglePlex!,
                              onMapCreated: (GoogleMapController controller) {
                                model.gmc = controller;
                                // mapController!.setMapToolbarEnabled(false);
                                controller.setMapStyle(mapTheme);
                                _controller.complete(controller);
                              },
                              // markers: myMarker,
                              // onTap: (latlng) {
                              //   myMarker.remove(
                              //     const Marker(
                              //       markerId: MarkerId("1"),
                              //     ),
                              //   );
                              //   myMarker.add(
                              //     Marker(
                              //       markerId: const MarkerId("1"),
                              //       position: latlng,
                              //     ),
                              //   );
                              //   setState(() {});
                              // },
                              zoomControlsEnabled: false,
                              myLocationEnabled: true,
                              // padding: const EdgeInsets.only(bottom: 1000),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
// dart run flutter_native_splash:create 
// dart run flutter_launcher_icons