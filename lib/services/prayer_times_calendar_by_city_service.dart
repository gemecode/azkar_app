import 'dart:convert';

import 'package:http/http.dart' as http;

class GetPrayerTimesCalendarByCityService {
  Future<Map<String, dynamic>> fetchData({
    required String year,
    required String month,
    required String country,
    required String city,
  }) async {
    final response = await http.get(Uri.parse(
        'https://api.aladhan.com/v1/calendarByCity/$year/$month?city=$city&country=$country&method=5'));

    if (response.statusCode == 200) {
      // تحويل البيانات من صيغة JSON
      final Map<String, dynamic> data = json.decode(response.body);

      // استخدام البيانات كما تحتاج
      // print(data);
      return data;
      // print('Title: ${data['timings']['Fajr']}');
    } else {
      // في حالة وجود خطأ في الاستجابة
      // print('Failed to load data. Status Code: ${response.statusCode}');
      throw ('Failed to load data. Status Code: ${response.statusCode}');
    }
  }
}
