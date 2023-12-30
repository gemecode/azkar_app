import 'package:azkar_app/helpers/background_with_gradient_color.dart';
import 'package:azkar_app/helpers/qiblah_compass.dart';
import 'package:azkar_app/models/my_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class QiblaCompasView extends StatefulWidget {
  const QiblaCompasView({super.key});

  @override
  State<QiblaCompasView> createState() => _QiblaCompasViewState();
}

class _QiblaCompasViewState extends State<QiblaCompasView> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MyModel>(context, listen: true);

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
                  child: Column(
                    children: [
                      const Spacer(),
                      model.theme == 'Light'
                          ? Image.asset('assets/images/icons8-kaaba-50.png')
                          : ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                  Color(0XFFBD874F), BlendMode.modulate),
                              child: Image.asset(
                                  'assets/images/icons8-kaaba-50.png')),
                      const Spacer(),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).width * 0.75,
                        child: FutureBuilder(
                          future: _deviceSupport,
                          builder: (_, AsyncSnapshot<bool?> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: model.theme == 'Light'
                                      ? Colors.brown
                                      : const Color.fromARGB(255, 226, 146, 67),
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child:
                                    Text("Error: ${snapshot.error.toString()}"),
                              );
                            }
                            if (snapshot.data!) {
                              return const QiblahCompass();
                            } else {
                              return Center(
                                child: Text(
                                  // "Your device is not supported",
                                  "هذا الجهاز لا يدعم مستشعر الجيروسكوب",
                                  style: TextStyle(
                                    color: model.theme == 'Light'
                                        ? Colors.black
                                        : const Color.fromARGB(
                                            255, 226, 146, 67),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const Spacer(),
                      FutureBuilder(
                          future: _deviceSupport,
                          builder: (_, AsyncSnapshot<bool?> snapshot) {
                            if (snapshot.data!) {
                              return Text(
                                "قم بتدوير الهاتف يميناً ويساراً حتى يصبح رأس الدبوس \nفي محازاة الكعبه",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: model.theme == 'Light'
                                      ? Colors.black
                                      : const Color.fromARGB(255, 226, 146, 67),
                                ),
                              );
                            }
                            return const Text("");
                          }),
                      const Spacer(flex: 2),
                    ],
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
