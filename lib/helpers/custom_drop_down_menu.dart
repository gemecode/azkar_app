import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.controller,
    this.textFieldDecoration,
    this.dialogColor,
    required this.list,
    required this.dialogTitle,
    required this.search,
    required this.textFieldHight,
    required this.dialogHight,
    this.dialogTextColor,
    this.dialogbuttonColor,
    this.dialogbuttonTextColor,
    this.hint,
    this.textColor,
  });

  final TextEditingController controller;
  final List<String> list;
  final String dialogTitle;
  final InputDecoration? textFieldDecoration;
  final Color? textColor;
  final Color? dialogColor;
  final Color? dialogTextColor;
  final Color? dialogbuttonColor;
  final Color? dialogbuttonTextColor;
  final bool? hint;
  final bool search;
  final double textFieldHight;
  final double dialogHight;

  @override
  State<CustomDropdown> createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  List<String> textList = [];
  List<String> textSubList = [];
  String title = '';

  /////////////
  // bool search = false;
  // double dialogHight = 100;
  // double textFieldHight = 20;

  @override
  void initState() {
    getText(widget.list);
    super.initState();
  }

  getText(List<String> myList) {
    textList.clear();
    textList = myList;
    textSubList = textList;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.textFieldHight,
      child: TextField(
        controller: widget.controller,
        onTap: () {
          setState(() {
            title = widget.dialogTitle;
            showDialog(context);
          });
        },
        style: TextStyle(color: widget.textColor),
        decoration: widget.textFieldDecoration == null
            ? defaultDecoration
            : widget.textFieldDecoration!,
        readOnly: true,
      ),
    );
  }

  void showDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showGeneralDialog(
      barrierLabel: title,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 350),
      context: context,
      pageBuilder: (context, __, ___) {
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: widget.dialogHight,
                  margin: const EdgeInsets.only(top: 60, left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: widget.dialogColor ?? Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(title,
                          style: TextStyle(
                              color: widget.dialogTextColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),

                      ///Text Field
                      widget.search == true
                          ? TextField(
                              controller: controller,
                              onChanged: (val) {
                                setState(() {
                                  textSubList = textList
                                      .where((element) => element
                                          .toLowerCase()
                                          .contains(
                                              controller.text.toLowerCase()))
                                      .toList();
                                });
                              },
                              style: TextStyle(
                                  color: widget.dialogTextColor,
                                  fontSize: 16.0),
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: "Search here...",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 5),
                                  isDense: true,
                                  prefixIcon: Icon(Icons.search)),
                            )
                          : Divider(
                              color: widget.dialogTextColor,
                            ),

                      ///Dropdown Items
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          itemCount: textSubList.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  widget.controller.text = textSubList[index];
                                  textSubList = textList;
                                });
                                controller.clear();
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20.0, left: 10.0, right: 10.0),
                                child: Text(textSubList[index],
                                    style: TextStyle(
                                        color: widget.dialogTextColor,
                                        fontSize: 16.0)),
                              ),
                            );
                          },
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: widget.dialogbuttonColor,
                            foregroundColor: widget.dialogbuttonTextColor,
                            shadowColor: widget.dialogbuttonTextColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        onPressed: () {
                          textSubList = textList;
                          controller.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16.0))));
  }

  InputDecoration defaultDecoration = const InputDecoration(
      isDense: true,
      hintText: 'Select',
      suffixIcon: Icon(Icons.arrow_drop_down),
      border: OutlineInputBorder());
}
