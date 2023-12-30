import 'package:azkar_app/helpers/app_routes.dart';
import 'package:azkar_app/helpers/app_theme.dart';
import 'package:azkar_app/models/my_model.dart';
import 'package:azkar_app/views/compas_view.dart';
import 'package:azkar_app/views/home_view.dart';
import 'package:azkar_app/views/nearest_mosque_view.dart';
import 'package:azkar_app/views/prayer_times_view.dart';
import 'package:azkar_app/views/search_country_state_city_view.dart';
import 'package:azkar_app/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen = 0;
// String? country;
// String? state;
// String? city;
// String? timeFormat;
// String? theme;
// bool isRTL = true;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  // theme = prefs.getString("theme");
  // country = prefs.getString("country");
  // state = prefs.getString("state");
  // city = prefs.getString("city");
  // print('#################################################33');
  // print(theme);
  // print(country);
  // print(state);
  // print(city);
  // timeFormat = prefs.getString("timeFormat");
  // await prefs.setInt("initScreen", 1);

  runApp(
    ChangeNotifierProvider(
      create: (context) => MyModel(),
      child: const AzkarApp(),
    ),
  );
}

class AzkarApp extends StatelessWidget {
  const AzkarApp({super.key});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MyModel>(context, listen: true);

    return MaterialApp(
      // builder: (context, child) {
      //   return Directionality(
      //     textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      //     child: child!,
      //   );
      // },
      debugShowCheckedModeBanner: false,
      theme: model.theme != "Light" ? AppTheme.lightTheme : AppTheme.darkTheme,
      // theme: theme == 'Light' ? AppTheme.lightTheme : AppTheme.darkTheme,
      // home: const SearchCountryStateCityView(),

      initialRoute:
          initScreen == 0 || initScreen == null ? "searchCountry" : "home",
      routes: {
        AppRoutes.home: (context) => const HomeView(
            // country: country!,
            // state: state!,
            // city: city!,
            ),
        AppRoutes.searchCountry: (context) =>
            const SearchCountryStateCityView(),
        AppRoutes.prayerTimesView: (context) => const PrayerTimesView(),
        AppRoutes.qiblaCompasView: (context) => const QiblaCompasView(),
        AppRoutes.nearestMosqueView: (context) => const NearestMosqueView(),
        AppRoutes.settingsView: (context) => const SettingsView(),
      },
    );
  }
}
