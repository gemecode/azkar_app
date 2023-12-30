// ignore_for_file: use_build_context_synchronously
import 'package:azkar_app/helpers/background_with_gradient_color.dart';
import 'package:azkar_app/helpers/custom_drop_down_menu.dart';
import 'package:azkar_app/models/my_model.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final model = Provider.of<MyModel>(context, listen: false);
      model.loadSavedData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MyModel>(context, listen: true);

    return Scaffold(
        body: BackgroundWithGradientColor(
      child: Stack(
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
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: model.theme == 'Light'
                      ? Colors.brown
                      : Colors.grey.shade900,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              height: MediaQuery.sizeOf(context).height * 0.88,
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: model.theme == 'Light'
                          ? const Color.fromARGB(255, 249, 249, 249)
                          : const Color.fromARGB(255, 60, 50, 40),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  height: MediaQuery.sizeOf(context).height * 0.86,
                  width: MediaQuery.sizeOf(context).width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'الإعدادت',
                              style: TextStyle(
                                color: model.theme == 'Light'
                                    ? Color(0XFF534141)
                                    : Color.fromARGB(255, 226, 146, 67),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            model.theme == 'Light'
                                ? Image.asset(
                                    'assets/images/gear-settings-nob.png',
                                    height: 35,
                                  )
                                : ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                        Color(0XFFBD874F), BlendMode.modulate),
                                    child: Image.asset(
                                      'assets/images/gear-settings-nob.png',
                                      height: 35,
                                    ),
                                  )
                          ],
                        ),

                        // SizedBox(
                        //     height:
                        //         MediaQuery.sizeOf(context).height * 0.07),

                        const Spacer(),

                        // const MyCustomDropdown(
                        //   items: [
                        //     'Option 1',
                        //     'Option 2',
                        //     'Option 3',
                        //     'Option 4'
                        //   ],
                        // ),

                        CountryStateCityPicker(
                          theme: model.theme,
                          textFieldHight: MediaQuery.sizeOf(context).height *
                              .07.toDouble(),
                          hint: false,
                          country: model.settingCountryController,
                          state: model.settingStateController,
                          city: model.settingCityController,
                          dialogColor: model.theme == "Light"
                              ? Colors.grey.shade100
                              : Colors.grey.shade900,
                          dialogTextColor: model.theme == "Light"
                              ? Colors.grey.shade800
                              : Colors.white,
                          dialogSearchColor: model.theme == "Light"
                              ? Colors.brown
                              : Colors.white,
                          dialogSearchHintColor: model.theme == "Light"
                              ? Colors.grey
                              : Colors.grey,
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
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: model.theme == 'Light'
                                      ? Colors.grey
                                      : Colors.grey.shade600,
                                  width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: model.theme == 'Light'
                                      ? Colors.brown
                                      : const Color.fromARGB(255, 226, 146, 67),
                                  width: 1.0),
                            ),
                            fillColor: model.theme == "Light"
                                ? Colors.white70
                                : Colors.black12,
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
                                  ? Colors.brown
                                  : const Color.fromARGB(255, 226, 146, 67),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.01,
                        ),

                        CustomDropdown(
                          controller: model.settingLanguageController,
                          list: const [
                            'Arabic',
                            // 'English',
                          ],
                          dialogTitle: 'language',
                          dialogColor: model.theme == "Light"
                              ? Colors.grey.shade100
                              : Colors.grey.shade900,
                          dialogTextColor: model.theme == "Light"
                              ? Colors.grey.shade800
                              : Colors.white,
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
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: model.theme == 'Light'
                                      ? Colors.grey
                                      : Colors.grey.shade600,
                                  width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: model.theme == 'Light'
                                      ? Colors.brown
                                      : const Color.fromARGB(255, 226, 146, 67),
                                  width: 1.0),
                            ),
                            fillColor: model.theme == "Light"
                                ? Colors.white70
                                : Colors.black12,
                            filled: true,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down),
                            suffixIconColor: model.theme == 'Light'
                                ? Colors.brown
                                : const Color.fromARGB(255, 226, 146, 67),
                            labelText: 'language',
                            labelStyle: TextStyle(
                                color: model.theme == 'Light'
                                    ? Colors.brown
                                    : Colors.grey.shade600),
                            hintStyle: TextStyle(
                              color: model.theme == 'Light'
                                  ? Colors.brown
                                  : const Color.fromARGB(255, 226, 146, 67),
                            ),
                          ),
                          textFieldHight:
                              MediaQuery.sizeOf(context).height * .07,
                          dialogHight: MediaQuery.sizeOf(context).height * .25,
                          search: false,
                        ),

                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.01,
                        ),
                        CustomDropdown(
                          controller: model.settingTimeFormatController,
                          list: const ['24 hours', '12 hours'],
                          dialogTitle: 'Time format',
                          dialogColor: model.theme == "Light"
                              ? Colors.grey.shade100
                              : Colors.grey.shade900,
                          dialogTextColor: model.theme == "Light"
                              ? Colors.grey.shade800
                              : Colors.white,
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
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: model.theme == 'Light'
                                      ? Colors.grey
                                      : Colors.grey.shade600,
                                  width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: model.theme == 'Light'
                                      ? Colors.brown
                                      : const Color.fromARGB(255, 226, 146, 67),
                                  width: 1.0),
                            ),
                            fillColor: model.theme == "Light"
                                ? Colors.white70
                                : Colors.black12,
                            filled: true,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down),
                            suffixIconColor: model.theme == 'Light'
                                ? Colors.brown
                                : const Color.fromARGB(255, 226, 146, 67),
                            labelText: 'Time format',
                            labelStyle: TextStyle(
                                color: model.theme == 'Light'
                                    ? Colors.brown
                                    : Colors.grey.shade600),
                            hintStyle: TextStyle(
                              color: model.theme == 'Light'
                                  ? Colors.brown
                                  : const Color.fromARGB(255, 226, 146, 67),
                            ),
                          ),
                          textFieldHight:
                              MediaQuery.sizeOf(context).height * .07,
                          dialogHight: MediaQuery.sizeOf(context).height * .3,
                          search: false,
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.01,
                        ),
                        CustomDropdown(
                          controller: model.settingDateController,
                          list: const [
                            'Gregorian and Hijri',
                            'Gregorian only',
                            'Hijri only',
                            'No date'
                          ],
                          dialogTitle: 'Date',
                          dialogColor: model.theme == "Light"
                              ? Colors.grey.shade100
                              : Colors.grey.shade900,
                          dialogTextColor: model.theme == "Light"
                              ? Colors.grey.shade800
                              : Colors.white,
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
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: model.theme == 'Light'
                                      ? Colors.grey
                                      : Colors.grey.shade600,
                                  width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: model.theme == 'Light'
                                      ? Colors.brown
                                      : const Color.fromARGB(255, 226, 146, 67),
                                  width: 1.0),
                            ),
                            fillColor: model.theme == "Light"
                                ? Colors.white70
                                : Colors.black12,
                            filled: true,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down),
                            suffixIconColor: model.theme == 'Light'
                                ? Colors.brown
                                : const Color.fromARGB(255, 226, 146, 67),
                            labelText: 'Date',
                            labelStyle: TextStyle(
                                color: model.theme == 'Light'
                                    ? Colors.brown
                                    : Colors.grey.shade600),
                            hintStyle: TextStyle(
                              color: model.theme == 'Light'
                                  ? Colors.brown
                                  : const Color.fromARGB(255, 226, 146, 67),
                            ),
                          ),
                          textFieldHight:
                              MediaQuery.sizeOf(context).height * .07,
                          dialogHight: MediaQuery.sizeOf(context).height * .4,
                          search: false,
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.01,
                        ),

                        CustomDropdown(
                          controller: model.settingThemeController,
                          list: const [
                            'Light',
                            'Dark',
                          ],
                          dialogTitle: 'Theme',
                          dialogColor: model.theme == "Light"
                              ? Colors.grey.shade100
                              : Colors.grey.shade900,
                          dialogTextColor: model.theme == "Light"
                              ? Colors.grey.shade800
                              : Colors.white,
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
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: model.theme == 'Light'
                                      ? Colors.grey
                                      : Colors.grey.shade600,
                                  width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: model.theme == 'Light'
                                      ? Colors.brown
                                      : const Color.fromARGB(255, 226, 146, 67),
                                  width: 1.0),
                            ),
                            fillColor: model.theme == "Light"
                                ? Colors.white70
                                : Colors.black12,
                            filled: true,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down),
                            suffixIconColor: model.theme == 'Light'
                                ? Colors.brown
                                : const Color.fromARGB(255, 226, 146, 67),
                            labelText: 'Theme',
                            labelStyle: TextStyle(
                                color: model.theme == 'Light'
                                    ? Colors.brown
                                    : Colors.grey.shade600),
                            hintStyle: TextStyle(
                              color: model.theme == 'Light'
                                  ? Colors.brown
                                  : const Color.fromARGB(255, 226, 146, 67),
                            ),
                          ),
                          textFieldHight:
                              MediaQuery.sizeOf(context).height * .07,
                          dialogHight: MediaQuery.sizeOf(context).height * .3,
                          search: false,
                        ),

                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.01,
                        ),

                        MaterialButton(
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minWidth: double.infinity,
                          height: 50,
                          onPressed: () async {
                            await model.savedChanges(context, model.theme);
                          },
                          color: model.theme == "Light"
                              ? Colors.brown
                              : Colors.grey.shade800,
                          elevation: 10,
                          child: Text(
                            // 'Done'
                            'حفظ التغيرات',
                            style: TextStyle(
                                color: model.theme == 'Light'
                                    ? Colors.white
                                    : const Color.fromARGB(255, 226, 146, 67)),
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
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
