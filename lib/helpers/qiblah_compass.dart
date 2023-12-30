import 'dart:async';
import 'dart:math' show pi;
// import 'package:sensors/sensors.dart';

import 'package:azkar_app/models/my_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'location_error_widget.dart';

class QiblahCompass extends StatefulWidget {
  const QiblahCompass({super.key});

  @override
  QiblahCompassState createState() => QiblahCompassState();
}

class QiblahCompassState extends State<QiblahCompass> {
  final locationStreamController = StreamController<LocationStatus>.broadcast();

  get stream => locationStreamController.stream;

  Future<void> _checkLocationStatus() async {
    // before running the app please enable your location

    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      locationStreamController.sink.add(s);
    } else {
      locationStreamController.sink.add(locationStatus);
    }
  }

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    locationStreamController.close();
    FlutterQiblah().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.enabled == true) {
            switch (snapshot.data!.status) {
              case LocationPermission.always:
              case LocationPermission.whileInUse:
                return QiblahCompassWidget();

              case LocationPermission.denied:
                return LocationErrorWidget(
                  error: "Location service permission denied",
                  callback: _checkLocationStatus,
                );
              case LocationPermission.deniedForever:
                return LocationErrorWidget(
                  error: "Location service Denied Forever !",
                  callback: _checkLocationStatus,
                );
              default:
                return Container();
            }
          } else {
            return LocationErrorWidget(
              error: "Please enable Location service",
              callback: _checkLocationStatus,
            );
          }
        },
      ),
    );
  }
}

class QiblahCompassWidget extends StatelessWidget {
  final _compassSvg = SvgPicture.asset('assets/compass.svg');
  final _compassSvg2 = ColorFiltered(
      colorFilter:
          const ColorFilter.mode(Color(0XFFBD874F), BlendMode.modulate),
      child: SvgPicture.asset('assets/compass.svg'));

  final _needleSvg = SvgPicture.asset(
    'assets/needle.svg',
    fit: BoxFit.contain,
    height: 300,
    alignment: Alignment.center,
  );

  final _needleSvg2 = ColorFiltered(
    colorFilter: const ColorFilter.mode(Color(0XFFBD874F), BlendMode.modulate),
    child: SvgPicture.asset(
      'assets/needle.svg',
      fit: BoxFit.contain,
      height: 300,
      alignment: Alignment.center,
    ),
  );

  QiblahCompassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MyModel>(context, listen: true);

    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: model.theme == 'Light'
                  ? Colors.brown
                  : const Color.fromARGB(255, 226, 146, 67),
            ),
          );
        }

        final qiblahDirection = snapshot.data!;

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.rotate(
              angle: (qiblahDirection.direction * (pi / 180) * -1),
              child: model.theme == 'Light' ? _compassSvg : _compassSvg2,
            ),
            Transform.rotate(
              angle: (qiblahDirection.qiblah * (pi / 180) * -1),
              alignment: Alignment.center,
              child: model.theme == 'Light' ? _needleSvg : _needleSvg2,
            ),
            const Positioned(
              bottom: 8,
              child:
                  // Text("${qiblahDirection.offset.toStringAsFixed(3)}°"),
                  Text(""),
            )
          ],
        );
      },
    );
  }
}
