// ignore_for_file: prefer_interpolation_to_compose_strings
import 'dart:async';
import 'package:azkar_app/helpers/background_with_gradient_color.dart';
import 'package:azkar_app/helpers/convert_to_arabic_month.dart';
import 'package:azkar_app/helpers/convert_to_arabic_numbers.dart';
import 'package:azkar_app/helpers/countdown_timer_widget.dart';
import 'package:azkar_app/models/my_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final model = Provider.of<MyModel>(context, listen: false);
      model.feachData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MyModel>(context, listen: true);

    final screenWidth = MediaQuery.of(context).size.width -
        MediaQuery.sizeOf(context).height * 0.06 -
        24 -
        16;
    final screenHeight = MediaQuery.of(context).size.height * 0.42 -
        MediaQuery.of(context).padding.top -
        24 -
        16;
    const crossAxisCount = 2;
    final itemWidth = screenWidth / crossAxisCount;
    final itemHeight = screenHeight / crossAxisCount;

    return Scaffold(
      body: model.jsonData.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              color: model.theme == 'Light'
                  ? Colors.brown
                  : const Color.fromARGB(255, 226, 146, 67),
            ))
          : BackgroundWithGradientColor(
              child: Column(
                children: [
                  Stack(
                    children: [
                      model.theme == "Light"
                          ? Image.asset(
                              'assets/images/masjid_removebg.png',
                              fit: BoxFit.cover,
                              height: MediaQuery.sizeOf(context).height * 0.35,
                              width: double.infinity,
                            )
                          : ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                  Color(0XFFBD874F), BlendMode.modulate),
                              child: Image.asset(
                                'assets/images/masjid_removebg.png',
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.35,
                                width: double.infinity,
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.sizeOf(context).height * 0.01),
                          alignment: Alignment.center,
                          child: Text(
                            'إلا صلاتي',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: model.theme == 'Light'
                                  ? const Color(0XFFF9F9F9)
                                  : const Color(0XFFBD874F),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: model.theme == 'Light'
                          ? const Color.fromARGB(255, 249, 249, 249)
                          : const Color.fromARGB(255, 60, 50, 40),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    height: MediaQuery.sizeOf(context).height * 0.63,
                    width: MediaQuery.sizeOf(context).width -
                        MediaQuery.sizeOf(context).height * 0.06,
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.03,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
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
                                      height: 1,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      color: model.theme == 'Light'
                                          ? const Color(0XFFC39F7A)
                                          : const Color.fromARGB(
                                              255, 226, 146, 67),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
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
                                      height: 1,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      color: model.theme == 'Light'
                                          ? const Color(0XFFC39F7A)
                                          : const Color.fromARGB(
                                              255, 226, 146, 67),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01),
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  model.theme == 'Light'
                                      ? const Color(0XFFba9673)
                                      : const Color.fromARGB(255, 14, 8, 7),
                                  model.theme == 'Light'
                                      ? const Color(0XFFcdb8a0)
                                      : const Color.fromARGB(255, 26, 17, 15),
                                ], // Define your gradient colors here
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    model.city,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: model.theme == 'Light'
                                          ? Colors.white
                                          : const Color(0XFFBD874F),
                                    ),
                                  ),
                                  //  Row(
                                  //   children: [
                                  //     const Icon(
                                  //       Icons.my_location,
                                  //       color: Colors.white,
                                  //       size: 24,
                                  //     ),
                                  //     const SizedBox(width: 12),
                                  //     Text(
                                  //       widget.city,
                                  //       style: const TextStyle(
                                  //         fontSize: 14,
                                  //         fontWeight: FontWeight.w600,
                                  //         color: Colors.white,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(
                                    Icons.my_location,
                                    color: model.theme == 'Light'
                                        ? Colors.white
                                        : const Color(0XFFBD874F),
                                    size: 18,
                                  ),
                                  //  Icon(
                                  //   Icons.keyboard_arrow_down,
                                  //   color: Colors.white,
                                  //   size: 28,
                                  // ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.03),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.10,
                            child: Column(children: [
                              CountdownTimerWidget.create(
                                countDownTimerColor: model.theme == 'Light'
                                    ? const Color(0XFF886B4E)
                                    : const Color.fromARGB(255, 226, 146, 67),
                                initialMinutes:
                                    int.parse(model.smallestTime.toString()),
                                endText: 'الآن',
                                onTimerEnd: () {
                                  print("***********************************");
                                  print('Countdown complete!');
                                  Timer(const Duration(minutes: 1),
                                      model.getNearestPray);
                                },
                              ),
                              const SizedBox(height: 5),
                              Text(
                                model.nearestPray,
                                style: const TextStyle(
                                  height: 1,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFFBD874F),
                                ),
                              ),
                            ]),
                          ),
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01),
                          Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.all(0),
                              // scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 3, // Adjust as needed
                                mainAxisSpacing: 3, // Adjust as needed
                                childAspectRatio: itemWidth / itemHeight,
                                // childAspectRatio: itemHeight / itemWidth,
                              ),

                              itemCount:
                                  model.features.length, // Number of grid items
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      model.features[index]['path'].toString(),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      model.theme == 'Light'
                                          ? Image.asset(
                                              model.features[index]['image']
                                                  .toString(),
                                              height: itemHeight * 0.75,
                                              width: itemWidth,
                                              fit: BoxFit.contain,
                                            )
                                          : ColorFiltered(
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      Color(0XFFBD874F),
                                                      BlendMode.modulate),
                                              child: Image.asset(
                                                model.features[index]['image']
                                                    .toString(),
                                                height: itemHeight * 0.75,
                                                width: itemWidth,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                      Text(
                                        model.features[index]['name']
                                            .toString(),
                                        style: const TextStyle(
                                          height: 1,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0XFFBD874F),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ), // Expanded(
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(height: 24)
                ],
              ),
            ),
      //     } else {
      //       return const Text('error');
      //     }
      //   },
      // ),;
    );
  }
}
