import 'dart:convert';
import 'package:azkar_app/services/prayer_times_calendar_by_city_service.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> fetchDataOnceEveryMonth({
  required String year,
  required String month,
  required String country,
  required String city,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Check if data was already fetched this month
  DateTime lastFetchDate =
      DateTime.parse(prefs.getString('lastFetchDate') ?? '1970-01-01');
  DateTime now = DateTime.now();

  // Check if country and city have changed
  String storedCountry = prefs.getString('storedCountry') ?? "";
  String storedCity = prefs.getString('storedCity') ?? "";

  if (now.month > lastFetchDate.month ||
      (now.month == lastFetchDate.month && now.day > lastFetchDate.day) ||
      country != storedCountry ||
      city != storedCity) {
    // Check for internet connectivity
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection, use existing data
      return;
    }

    // Internet is available, fetch your data here
    try {
      // String newData = await fetchDataFromApi();
      Map<String, dynamic> newData = await GetPrayerTimesCalendarByCityService()
          .fetchData(year: year, month: month, country: country, city: city);

      // Save the fetched data
      String jsonData = json.encode(newData);
      prefs.setString('yourDataKey', jsonData);
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      print(jsonData);

      // Save the current country and city to indicate that data was fetched for these parameters
      prefs.setString('storedCountry', country);
      prefs.setString('storedCity', city);

      // Save the current date to indicate that data was fetched this month
      prefs.setString('lastFetchDate', now.toIso8601String());
    } catch (error) {
      // Handle error fetching data from the API
      print('Error fetching data: $error');
    }
  }
}
