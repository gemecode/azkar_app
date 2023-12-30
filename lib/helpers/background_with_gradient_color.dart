import 'package:azkar_app/models/my_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackgroundWithGradientColor extends StatelessWidget {
  const BackgroundWithGradientColor({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MyModel>(context, listen: true);

    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
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
      child: child,
    );
  }
}
