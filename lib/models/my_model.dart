// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'package:azkar_app/helpers/app_routes.dart';
import 'package:azkar_app/helpers/app_theme.dart';
import 'package:azkar_app/helpers/fetch_data_once_every_month.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyModel with ChangeNotifier {
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String country = "";
  String state = "";
  String city = "";
  String language = "Arabic";
  String timeFormat = "24 hours";
  String date = "Gregorian and Hijri";
  String theme = "Light";

  late SharedPreferences prefs;
  late String stringData;
  Map<String, dynamic> jsonData = {};

  ////////////////////////////////
  ///navigate to home_view

  goToHomeView(BuildContext context, String theme) async {
    if (countryController.text.toString() == '' ||
        stateController.text.toString() == '' ||
        cityController.text.toString() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: theme == 'Light'
              ? AppTheme.lightTheme.primaryColor
              : AppTheme.darkTheme.primaryColor,
          content: Text(
            // 'Please Fill In The Empty Fields',
            'يرجى ملء الحقول الفارغة',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: theme == 'Light'
                    ? Colors.white
                    : const Color.fromARGB(255, 226, 146, 67),
                fontSize: 16.0),
          )));
    } else {
      prefs = await SharedPreferences.getInstance();
      await prefs.setInt("initScreen", 1);
      await prefs.setString("country", countryController.text.toString());
      await prefs.setString("state", stateController.text.toString());
      await prefs.setString("city", cityController.text.toString());
      await prefs.setString("language", language);
      await prefs.setString("timeFormat", timeFormat);
      await prefs.setString("date", date);
      await prefs.setString("theme", theme);
      feachData();
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  feachData() async {
    prefs = await SharedPreferences.getInstance();
    await fetchDataOnceEveryMonth(
        year: DateTime.now().year.toString(),
        month: DateTime.now().month.toString(),
        country: prefs.getString("country").toString(),
        city: prefs.getString("city").toString());
    await getSavedData();
    await getNearestPray();
    notifyListeners();
  }

  /////////////////////

  getSavedData() async {
    prefs = await SharedPreferences.getInstance();
    stringData = prefs.getString('yourDataKey')!;
    jsonData = json.decode(stringData);
    country = prefs.getString("country") ?? "";
    state = prefs.getString("state") ?? "";
    city = prefs.getString("city") ?? "";
    language = prefs.getString("language") ?? "";
    timeFormat = prefs.getString("timeFormat") ?? "";
    date = prefs.getString("date") ?? "";
    theme = prefs.getString("theme") ?? "";
    print('########################################');
    print(jsonData);
  }

  /////////////////////
  String nearestPray = '';
  DateTime prayTime = DateTime.now();
  int smallestTime = 0;
  List<String> prayers = [
    "Fajr",
    "Sunrise",
    "Dhuhr",
    "Asr",
    // "Sunset",
    "Maghrib",
    "Isha",
    // "Imsak",
    "Firstthird",
    "Midnight",
    "Lastthird"
  ];

  List<String> prayersAr = [
    "صلاة الفجر",
    "شروق الشمس",
    "صلاة الظهر",
    "صلاة العصر",
    // "غروب الشمس",
    "صلاة المغرب",
    "صلاة العشاء",
    // "إمساك",
    "بداية الثلث الأول من الليل",
    "بداية منتصف الليل",

    "بداية الثلث الأخير من الليل"
  ];

  /////////////////////

  getNearestPray() {
    print("******************prayers*****************");
    print(prayers);
    List<DateTime> prayerTimes = [];
    for (var element in prayers) {
      DateTime prayTime = DateFormat("hh:mm").parse(jsonData['data']
              [DateTime.now().day - 1]['timings'][element]
          .toString()
          .split(' ')[0]);

      // Duration durationToAdd = const Duration(minutes: 190);
      // DateTime sumDateTime = prayTime.subtract(durationToAdd);

      prayerTimes.add(prayTime);
    }
    print("*****************prayerTimes******************");
    print(prayerTimes);
    DateTime currentTime =
        DateFormat("hh:mm").parse(DateFormat.Hm().format(DateTime.now()));
    List<int> differencesTime = [];
    for (var element in prayerTimes) {
      differencesTime.add(element.difference(currentTime).inMinutes);
    }

    print("*****************differencesTime******************");
    print(differencesTime);

///////////////////
    int findSmallestPositive(List<int> numbers) {
      // Remove negative numbers
      List<int> positiveNumbers =
          numbers.where((number) => number >= 0).toList();

      // Sort the positive numbers
      positiveNumbers.sort();

      // Check if there are positive numbers
      if (positiveNumbers.isEmpty) {
        return 0; // No positive numbers found
      } else {
        return positiveNumbers.first; // Return the smallest positive number
      }
    }

    smallestTime = findSmallestPositive(differencesTime);
    print("***********************************");
    print(smallestTime);
    int index = differencesTime.indexOf(smallestTime);
    print("***********************************");
    print(index);
    nearestPray = prayersAr[index];
    prayTime = prayerTimes[index];
    ////////////////
    // notifyListeners();
    print("**********************************");
    print(nearestPray);
  }

/////////////////////

  final List<Map<String, dynamic>> features = [
    {
      'image': 'assets/images/clock.png',
      'name': 'المواقيت',
      'path': AppRoutes.prayerTimesView,
    },
    {
      'image': 'assets/images/compass.png',
      'name': 'القبله',
      'path': AppRoutes.qiblaCompasView,
    },
    {
      'image': 'assets/images/kubah.png',
      'name': 'المساجد',
      'path': AppRoutes.nearestMosqueView,
    },
    {
      'image': 'assets/images/gear-settings.png',
      'name': 'الإعدادات',
      'path': AppRoutes.settingsView,
    },
  ];

  //////////////////////////

  //////////////////////////////////////////////////////////////
  //////////////start nearest_moque_screen code/////////////////
  //////////////////////////////////////////////////////////////

  late Position currentLocation;
  late double lat;
  late double long;
  // late List<Placemark> placemarks;
  // late double distanceBetween;
  StreamSubscription<Position>? ps;
  /////////////////
  /////////////////

  GoogleMapController? gmc;
  CameraPosition? kGooglePlex;

  ////////////////////////////////////
  //////////custom marker start///////
  ////////////////////////////////////
  Set<Marker> myMarker = {};
  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
  //       .buffer
  //       .asUint8List();
  // }

  // setMarkerCustomImage(double lat, double long) async {
  //   final Uint8List markerIcon =
  //       await getBytesFromAsset('assets/vecteezy-green-mosque.png', 100);

  //   myMarker.add(
  //     Marker(
  //       // onTap: () {
  //       //   print('tap marker');
  //       // },
  //       // draggable: true,
  //       // onDragEnd: (LatLng t) {
  //       //   print('drag end');
  //       // },
  //       // visible: false,
  //       // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //       // icon: await BitmapDescriptor.fromAssetImage(
  //       //   const ImageConfiguration(size: Size(2, 2)),
  //       //   "assets/vecteezy-green-mosque.png",
  //       // ),
  //       icon: BitmapDescriptor.fromBytes(markerIcon),
  //       markerId: const MarkerId("1"),
  //       position: LatLng(lat, long),
  //       // infoWindow: InfoWindow(
  //       //   onTap: () {
  //       //     print('tap info marker');
  //       //   },
  //       //   title: "1",
  //       // ),
  //     ),
  //   );
  //   // setState(() {});
  // }
  ////////////////////////////////////
  ////////////////marker end///////////////
  ////////////////////////////////////

  ///##############################################///

  Future getPermission(BuildContext context, String theme) async {
    ///////////////
    bool services;
    LocationPermission permission;
    ///////////////
    services = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    ////////////////
    if (services == false) {
      // AwesomeDialog(
      //   context: context,
      //   title: 'Services',
      //   body: const Text('services not enabled\n'),
      // ).show();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        // backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: theme == 'Light'
            ? AppTheme.lightTheme.primaryColor
            : AppTheme.darkTheme.primaryColor,

        content: Center(
            child: Text(
          // 'services not enabled',
          'خدمات الموقع غير ممكّنة برجاء تمكينها',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: theme == 'Light'
                  ? Colors.white
                  : const Color.fromARGB(255, 226, 146, 67),
              fontSize: 16.0),
        )),
      ));
      Navigator.pop(context);
    }
    //////////////
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // if (permission == LocationPermission.always) {
      //   getLatLong();
      // }

      // Navigator
    }
    return permission;
  }

  ///##############################################///

  Future<void> getLatLong() async {
    currentLocation =
        await Geolocator.getCurrentPosition().then((value) => value);
    lat = currentLocation.latitude;
    long = currentLocation.longitude;
    // print("**************************************");

    // print(_kGooglePlex);

    kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 17.4746,
    );
    // print(_kGooglePlex);

    // await fetchMosques(lat, long, "AIzaSyAATlBliBSrVqmZ3k0TNFuD0nQGNlE3z1U");
    // await setMarkerCustomImage(lat, long);
    myMarker.add(
        Marker(markerId: const MarkerId("1"), position: LatLng(lat, long)));
    notifyListeners();
  }

  ///##############################################///

  // Future<List<Placemark>> getPlacemarks(double lat, double long) async {
  //   return await placemarkFromCoordinates(lat, long);
  // }

  ///##############################################///

  // double getDistanceBetween(
  //   double startLatitude,
  //   double startLongitude,
  //   double endLatitude,
  //   double endLongitude,
  // ) {
  //   return Geolocator.distanceBetween(
  //     startLatitude,
  //     startLongitude,
  //     endLatitude,
  //     endLongitude,
  //   );
  // }

  ///##############################################///

  changeMarker(newLat, newLong) {
    // myMarker.remove(
    //   const Marker(
    //     markerId: MarkerId("1"),
    //   ),
    // );
    myMarker.clear();
    myMarker.add(
      Marker(
        markerId: const MarkerId("1"),
        position: LatLng(newLat, newLong),
      ),
    );
  }

  // String apiKey = "";
  // String radius = "";
  // double la = 0.0;
  // double lo = 0.0;
  // void getNearbyPlaces() async {
  //   var url = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
  //           la.toString() +
  //           ',' +
  //           lo.toString() +
  //           '&radius=' +
  //           radius +
  //           '&key=' +
  //           apiKey);
  //   var response = await http.post(url);
  // }

  //////////////////////////////////////////////////////////////
  ////////////////////////////end code//////////////////////////
  //////////////////////////////////////////////////////////////

  TextEditingController settingCountryController = TextEditingController();
  TextEditingController settingStateController = TextEditingController();
  TextEditingController settingCityController = TextEditingController();
  TextEditingController settingLanguageController = TextEditingController();
  TextEditingController settingTimeFormatController = TextEditingController();
  TextEditingController settingDateController = TextEditingController();
  TextEditingController settingThemeController = TextEditingController();

  loadSavedData() async {
    prefs = await SharedPreferences.getInstance();
    settingCountryController.text = prefs.getString('country') ?? "";
    settingStateController.text = prefs.getString('state') ?? "";
    settingCityController.text = prefs.getString('city') ?? "";
    settingLanguageController.text = prefs.getString('language') ?? "";
    settingTimeFormatController.text = prefs.getString('timeFormat') ?? "";
    settingDateController.text = prefs.getString('date') ?? "";
    settingThemeController.text = prefs.getString('theme') ?? "";
    notifyListeners();
  }

  savedChanges(BuildContext context, String theme) async {
    if (settingCountryController.text.toString() == '' ||
        settingStateController.text.toString() == '' ||
        settingCityController.text.toString() == '' ||
        settingLanguageController.text.toString() == '' ||
        settingTimeFormatController.text.toString() == '' ||
        settingDateController.text.toString() == '' ||
        settingThemeController.text.toString() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: theme == 'Light'
              ? AppTheme.lightTheme.primaryColor
              : AppTheme.darkTheme.primaryColor,
          content: Text(
            // 'Please Fill In The Empty Fields',
            'يرجى ملء الحقول الفارغة',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: theme == 'Light'
                    ? Colors.white
                    : const Color.fromARGB(255, 226, 146, 67),
                fontSize: 16.0),
          )));
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString(
          "country", settingCountryController.text.toString());
      await prefs.setString("state", settingStateController.text.toString());
      await prefs.setString("city", settingCityController.text.toString());
      await prefs.setString(
          "language", settingLanguageController.text.toString());
      await prefs.setString(
          "timeFormat", settingTimeFormatController.text.toString());
      await prefs.setString("date", settingDateController.text.toString());
      await prefs.setString("theme", settingThemeController.text.toString());

      await feachData();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: theme == 'Light'
              ? AppTheme.lightTheme.primaryColor
              : AppTheme.darkTheme.primaryColor,
          content: Text(
            // 'Changes have been saved'
            'تم حفظ التغييرات',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: theme == 'Light'
                    ? Colors.white
                    : const Color.fromARGB(255, 226, 146, 67),
                fontSize: 16.0),
          )));
    }
  }
}
