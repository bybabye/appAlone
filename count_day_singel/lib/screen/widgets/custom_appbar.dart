import 'package:count_day_singel/screen/setting_date_page.dart';
import 'package:count_day_singel/theme/app_style.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    Key? key,
    required this.iconOne,
    required this.iconTwo,
    required this.text,
    required this.func,
    required this.funcDrawer,
  }) : super(key: key);
  final IconData iconOne;
  final IconData iconTwo;
  final String text;
  final Function() func;
  final Function() funcDrawer;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: funcDrawer,
            child: Icon(
              iconOne,
              color: Colors.white,
            ),
          ),
          Text(
            text,
            style: AppStyle.h1,
          ),
          InkWell(
            onTap: func,
            child: Icon(
              iconTwo,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
