// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   static const String navigationKey = 'navigation_done';
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       onGenerateRoute: (routeSettings) {
//         return MaterialPageRoute(
//           builder: (context) => Scaffold(
//             appBar: AppBar(
//               title: Text('الصفحة الرئيسية'),
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text('مرحبًا بك في التطبيق'),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () => navigateToNextPage(),
//                     child: Text('الانتقال إلى الصفحة التالية'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void navigateToNextPage() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isNavigated = prefs.getBool(navigationKey) ?? false;

//     if (!isNavigated) {
//       navigatorKey.currentState?.pushReplacement(
//         MaterialPageRoute(builder: (context) => SecondPage()),
//       );

//       prefs.setBool(navigationKey, true);
//     }
//   }
// }

// class SecondPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('الصفحة الثانية'),
//       ),
//       body: Center(
//         child: Text(
//           'أنت الآن في الصفحة الثانية',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }