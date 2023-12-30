// ignore_for_file: use_build_context_synchronously
import 'package:azkar_app/helpers/background_with_gradient_color.dart';
import 'package:azkar_app/models/my_model.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchCountryStateCityView extends StatelessWidget {
  const SearchCountryStateCityView({super.key});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MyModel>(context);

    return Scaffold(
      body: BackgroundWithGradientColor(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountryStateCityPicker(
                theme: model.theme,
                textFieldHight: MediaQuery.sizeOf(context).height * .10,
                hint: true,
                country: model.countryController,
                state: model.stateController,
                city: model.cityController,
                dialogColor: model.theme == "Light"
                    ? Colors.grey.shade100
                    : Colors.grey.shade900,
                dialogTextColor: model.theme == "Light"
                    ? Colors.grey.shade800
                    : Colors.white,
                dialogSearchColor: model.theme == "Light"
                    ? Colors.brown
                    : Colors.grey.shade900,
                dialogSearchHintColor:
                    model.theme == "Light" ? Colors.grey : Colors.grey.shade900,
                dialogbuttonColor: model.theme == "Light"
                    ? Colors.brown
                    : Colors.grey.shade900,
                dialogbuttonTextColor: Colors.white,
                textColor: model.theme == 'Light'
                    ? Colors.brown
                    : const Color.fromARGB(255, 226, 146, 67),
                textFieldDecoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: model.theme == 'Light'
                            ? Colors.brown
                            : Colors.grey.shade600,
                        width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: model.theme == 'Light'
                            ? Colors.brown.shade800
                            : const Color.fromARGB(255, 226, 146, 67),
                        width: 2.0),
                  ),
                  fillColor:
                      model.theme == "Light" ? Colors.white70 : Colors.black12,
                  filled: true,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                  suffixIconColor: model.theme == 'Light'
                      ? Colors.brown
                      : const Color.fromARGB(255, 226, 146, 67),
                  labelStyle: TextStyle(
                      color: model.theme == 'Light'
                          ? Colors.brown
                          : Colors.grey.shade600),
                  hintStyle: TextStyle(
                    color: model.theme == 'Light'
                        ? Colors.brown.shade400
                        : const Color.fromARGB(255, 226, 146, 67),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * .02),
              MaterialButton(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minWidth: double.infinity,
                height: 50,
                onPressed: () async {
                  await model.goToHomeView(context, model.theme);
                },
                color: model.theme == "Light"
                    ? Colors.brown
                    : Colors.grey.shade900,
                elevation: 10,
                child: const Text(
                  'Start',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
