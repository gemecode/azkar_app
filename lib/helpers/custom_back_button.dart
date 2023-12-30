import 'package:azkar_app/models/my_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MyModel>(context, listen: false);

    return IconButton(
      icon: Icon(FontAwesomeIcons.circleArrowLeft,
          color: model.theme == 'Light' ? Colors.white : Colors.black),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
