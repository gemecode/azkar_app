// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:azkar_app/helpers/background_with_gradient_color.dart';
import 'package:azkar_app/helpers/convert_to_arabic_month.dart';
import 'package:azkar_app/helpers/convert_to_arabic_numbers.dart';
import 'package:azkar_app/models/my_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MyModel>(context, listen: true);

    return Scaffold(
        body: BackgroundWithGradientColor(
      child: Stack(
        alignment: Alignment.bottomCenter,
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
            child: Container(
                height: MediaQuery.sizeOf(context).height * 0.75,
                decoration: BoxDecoration(
                  color: model.theme == 'Light'
                      ? const Color.fromARGB(255, 249, 249, 249)
                      : const Color.fromARGB(255, 60, 50, 40),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.15 -
                          MediaQuery.of(context).padding.top,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: ListView.builder(
                          itemCount: model.prayers.length,
                          itemBuilder: (context, index) {
                            return Card(
                                color: model.theme == 'Light'
                                    ? (model.prayersAr[index] ==
                                            model.nearestPray
                                        ? const Color.fromARGB(
                                            255, 229, 186, 140)
                                        : Colors.white)
                                    : (model.prayersAr[index] ==
                                            model.nearestPray
                                        ? const Color.fromARGB(0, 60, 50, 40)
                                        : const Color.fromARGB(255, 60, 50, 40)),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: (MediaQuery.sizeOf(context).height *
                                        0.60 /
                                        11),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              DateFormat(model.timeFormat ==
                                                          "24 hours"
                                                      ? 'HH:mm a'
                                                      : 'hh:mm a')
                                                  .format(DateFormat('HH:mm')
                                                      .parse(model.jsonData['data']
                                                              [DateTime.now()
                                                                      .day -
                                                                  1]['timings']
                                                          [model.prayers[index]]))
                                                  .toString(),
                                              style: TextStyle(
                                                color: model.theme == 'Light'
                                                    ? Colors.black
                                                    : const Color.fromARGB(255, 226, 146, 67),
                                              ),
                                            )),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              model.prayersAr[index],
                                              style: TextStyle(
                                                color: model.theme == 'Light'
                                                    ? Colors.black
                                                    : const Color.fromARGB(255, 226, 146, 67),
                                              ),
                                            )),
                                      ],
                                    )));
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * 0.60,
            child: Container(
              decoration: BoxDecoration(
                color: model.theme == 'Light'
                    ? Colors.brown
                    : Colors.grey.shade900,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: model.theme == 'Light'
                          ? const Color.fromARGB(255, 249, 249, 249)
                          : const Color.fromARGB(255, 60, 50, 40),
                      borderRadius: BorderRadius.circular(40)),
                  height: MediaQuery.sizeOf(context).height * 0.28,
                  width: MediaQuery.sizeOf(context).width,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Positioned(
                      //   top: 0,
                      //   right: 0,
                      //   left: 0,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(24),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         IconButton(
                      //           icon: const Icon(Icons.keyboard_arrow_left),
                      //           onPressed: () {
                      //             Navigator.pop(context);
                      //           },
                      //           color: const Color(0XFFCFB79E),
                      //         ),
                      //         const Icon(
                      //           Icons.menu,
                      //           color: Color(0XFFCFB79E),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        top: -10,
                        right: 0,
                        left: 0,
                        child: model.theme == "Light"
                            ? Image.asset(
                                'assets/images/clock_nobg.png',
                                height: 125,
                              )
                            : ColorFiltered(
                                colorFilter: const ColorFilter.mode(
                                    Color(0XFFBD874F), BlendMode.modulate),
                                child: Image.asset(
                                  'assets/images/clock_nobg.png',
                                  height: 125,
                                ),
                              ),
                      ),
                      Positioned(
                        top: 100,
                        right: 0,
                        left: 0,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'مواقيت الصلاة',
                            style: TextStyle(
                              color: model.theme == "Light"
                                  ? const Color(0XFF615356)
                                  : const Color.fromARGB(255, 226, 146, 67),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          right: 24,
                          left: 24,
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.my_location,
                                          size: 12,
                                          color: model.theme == 'Light'
                                              ? const Color(0XFF466C68)
                                              : const Color.fromARGB(
                                                  255, 226, 146, 67),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          model.city,
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: model.theme == 'Light'
                                                ? const Color(0XFF466C68)
                                                : const Color.fromARGB(
                                                    255, 226, 146, 67),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      model.date == 'Gregorian and Hijri' ||
                                              model.date == 'Hijri only'
                                          ? converttoarabicnumber(model.jsonData['data']
                                                      [DateTime.now().day - 1]
                                                  ['date']['hijri']['day']) +
                                              ' ' +
                                              model.jsonData['data']
                                                      [DateTime.now().day - 1]['date']
                                                  ['hijri']['month']['ar'] +
                                              ' ' +
                                              converttoarabicnumber(
                                                  model.jsonData['data'][DateTime.now().day - 1]['date']['hijri']['year'])
                                          : "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: model.theme == 'Light'
                                              ? const Color(0XFF6E636A)
                                              : const Color(0XFFBD874F)),
                                    )
                                  ],
                                ),
                                Text(
                                  model.date == 'Gregorian and Hijri' ||
                                          model.date == 'Gregorian only'
                                      ? model.jsonData['data'][DateTime.now().day - 1]['date']
                                              ['hijri']['weekday']['ar'] +
                                          ' - ' +
                                          converttoarabicnumber(model.jsonData['data']
                                                  [DateTime.now().day - 1]
                                              ['date']['gregorian']['day']) +
                                          ' ' +
                                          converttoarabicmonth(model.jsonData['data']
                                                  [DateTime.now().day - 1]['date']
                                                  ['gregorian']['month']['number']
                                              .toString()) +
                                          ' ' +
                                          converttoarabicnumber(model.jsonData['data'][DateTime.now().day - 1]['date']['gregorian']['year'])
                                      // +DateFormat.yMMMd("ar_SA").format(DateTime.now())
                                      : "",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: model.theme == 'Light'
                                          ? const Color(0XFF6E636A)
                                          : const Color(0XFFBD874F)),
                                ),
                              ],
                            ),
                          ))
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
