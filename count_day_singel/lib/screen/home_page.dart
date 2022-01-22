import 'dart:typed_data';

import 'package:count_day_singel/modules/util.dart';
import 'package:count_day_singel/screen/widgets/custom_appbar.dart';
import 'package:count_day_singel/share_key.dart';
import 'package:count_day_singel/theme/app_assets.dart';
import 'package:count_day_singel/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double sizeH;
  late double sizeW;
  String _selectedDate = DateTime.now().toString();

  Uint8List? fileX;

  bool isActive = false;

  late SharedPreferences prefs;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late int hour;
  late int minutes;
  late int second;
  late int year;
  late int month;

  late int day;

  _selectDateTime(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          height: sizeH * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  prefs = await SharedPreferences.getInstance();
                  await prefs.setString(ShareKey.date, _selectedDate);
                  Navigator.pop(context);
                },
                child: const Text("Xong"),
              ),
              SizedBox(
                height: sizeH * 0.3,
                width: sizeW * 0.8,
                child: ScrollDatePicker(
                  minimumYear: 2010,
                  maximumYear: 2050,
                  selectedDate: DateTime.parse(_selectedDate),
                  locale: DatePickerLocale.en_us,
                  options: const DatePickerOptions(),
                  onDateTimeChanged: (DateTime value) {
                    setState(() {
                      _selectedDate = value.toString();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initDefaultValue();
    hour = DateTime.now().hour;
    minutes = DateTime.now().minute;
    second = DateTime.now().second;
    if (DateTime.now().year - DateTime.parse(_selectedDate).year < 0) {
      year = 0;
    } else {
      year = DateTime.now().year - DateTime.parse(_selectedDate).year;
    }

    if (DateTime.now().month - DateTime.parse(_selectedDate).month < 0) {
      month = (DateTime.now().month - DateTime.parse(_selectedDate).month) + 12;
      year--;
    } else {
      month = DateTime.now().month - DateTime.parse(_selectedDate).month;
    }

    if (DateTime.now().day - DateTime.parse(_selectedDate).day < 0) {
      if (DateTime.now().month == 1 ||
          DateTime.now().month == 3 ||
          DateTime.now().month == 5 ||
          DateTime.now().month == 7 ||
          DateTime.now().month == 8 ||
          DateTime.now().month == 10 ||
          DateTime.now().month == 12) {
        day = (DateTime.now().day - DateTime.parse(_selectedDate).day) + 31;
      } else if (DateTime.now().month == 2) {
        if (DateTime.now().year % 4 == 0) {
          day = (DateTime.now().day - DateTime.parse(_selectedDate).day) + 29;
        } else {
          day = (DateTime.now().day - DateTime.parse(_selectedDate).day) + 28;
        }
      } else {
        day = (DateTime.now().day - DateTime.parse(_selectedDate).day) + 30;
      }
      if (month == 0) {
        month = 12;
        year--;
      } else {
        month--;
      }
    } else {
      day = DateTime.now().day - DateTime.parse(_selectedDate).day;
    }

    _timer();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(ShareKey.date) ?? DateTime.now().toString();

    setState(() {
      _selectedDate = value;
    });
  }

  void _timer() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        hour = DateTime.now().hour;
        minutes = DateTime.now().minute;
        second = DateTime.now().second;
        if (DateTime.now().year - DateTime.parse(_selectedDate).year < 0) {
          year = 0;
        } else {
          year = DateTime.now().year - DateTime.parse(_selectedDate).year;
        }
        if (DateTime.now().month - DateTime.parse(_selectedDate).month < 0) {
          month =
              (DateTime.now().month - DateTime.parse(_selectedDate).month) + 12;
          year--;
        } else {
          month = DateTime.now().month - DateTime.parse(_selectedDate).month;
        }

        if (DateTime.now().day - DateTime.parse(_selectedDate).day < 0) {
          if (DateTime.now().month == 1 ||
              DateTime.now().month == 3 ||
              DateTime.now().month == 5 ||
              DateTime.now().month == 7 ||
              DateTime.now().month == 8 ||
              DateTime.now().month == 10 ||
              DateTime.now().month == 12) {
            day = (DateTime.now().day - DateTime.parse(_selectedDate).day) + 31;
          } else if (DateTime.now().month == 2) {
            if (DateTime.now().year % 4 == 0) {
              day =
                  (DateTime.now().day - DateTime.parse(_selectedDate).day) + 29;
            } else {
              day =
                  (DateTime.now().day - DateTime.parse(_selectedDate).day) + 28;
            }
          } else {
            day = (DateTime.now().day - DateTime.parse(_selectedDate).day) + 30;
          }
          month--;
        } else {
          day = DateTime.now().day - DateTime.parse(_selectedDate).day;
        }
      });
      _timer();
    });
  }

  @override
  Widget build(BuildContext context) {
    sizeH = MediaQuery.of(context).size.height;
    sizeW = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      // drawer: Drawer(
      //   backgroundColor: Colors.grey[200],
      //   child: ListView(
      //     children: [
      //       DrawerHeader(
      //         child: Center(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: const [
      //               CircleAvatar(
      //                 radius: 50,
      //                 backgroundImage: AssetImage(AppAssets.kDra),
      //               ),
      //               Text(
      //                 "Ha Ha Đồ Ế !",
      //                 style: AppStyle.h2,
      //               ),
      //             ],
      //           ),
      //         ),
      //         decoration: const BoxDecoration(color: Colors.orange),
      //       ),
      //       InkWell(
      //         onTap: () {
      //           setState(() {
      //             isActive = true;
      //           });
      //           Navigator.pop(context);
      //         },
      //         child: SizedBox(
      //           height: sizeH * 0.08,
      //           child: const Card(
      //             elevation: 5,
      //             child: Text("Chọn BackGruond"),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.kBG,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomAppbar(
                iconOne: Icons.book_outlined,
                iconTwo: Icons.settings_outlined,
                text: "Alone Day Memory",
                func: () => _selectDateTime(context),
                funcDrawer: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      child: SizedBox(
                        height: sizeH * 0.2,
                        child: Center(
                          child: Text(
                            "Đồ Ế =))? Cái thứ Không có Người yêu",
                            style: AppStyle.h1.copyWith(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              customDatetime(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${DateTime.parse(_selectedDate).day}/${DateTime.parse(_selectedDate).month}/${DateTime.parse(_selectedDate).year}',
                    style: AppStyle.h2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customIconFavorite(hour.toString(), "Giờ"),
                      customIconFavorite(minutes.toString(), "Phút"),
                      customIconFavorite(second.toString(), "Giây"),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: sizeH * 0.1,
              ),
              Column(
                children: [
                  Center(
                    child: Stack(
                      children: const [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(AppAssets.kAvatar),
                        ),
                        // Positioned(
                        //   bottom: -10,
                        //   right: -10,
                        //   child: IconButton(
                        //     onPressed: () => _selectImage(context),
                        //     icon: const Icon(Icons.camera_alt),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Bạn",
                    style: AppStyle.h3,
                  )
                ],
              ),
              SizedBox(
                height: sizeH * 0.1,
              ),
            ],
          ),
          // isActive != false
          //     ? Positioned(
          //         bottom: 0,
          //         child: Container(
          //           height: sizeH * 0.25,
          //           width: sizeW,
          //           color: Colors.white,
          //           child: Column(
          //             children: [
          //               Expanded(
          //                 flex: 1,
          //                 child: InkWell(
          //                     onTap: () {
          //                       setState(
          //                         () {
          //                           isActive = false;
          //                         },
          //                       );
          //                     },
          //                     child: const Text("Xong")),
          //               ),
          //               Expanded(
          //                 flex: 4,
          //                 child: ListView.builder(
          //                   shrinkWrap: true,
          //                   scrollDirection: Axis.horizontal,
          //                   itemCount: images.length,
          //                   itemBuilder: (context, index) {
          //                     return Padding(
          //                       padding: const EdgeInsets.all(10.0),
          //                       child: Stack(
          //                         children: [
          //                           Image.asset(
          //                             images[index],
          //                             fit: BoxFit.cover,
          //                             filterQuality: FilterQuality.low,
          //                           ),
          //                         ],
          //                       ),
          //                     );
          //                   },
          //                 ),
          //               )
          //             ],
          //           ),
          //         ))
          //     : const Positioned(
          //         bottom: 0,
          //         child: SizedBox(),
          //       )
        ],
      ),
    );
  }

  Widget customDatetime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        customIconFavorite(year.toString(), "Năm"),
        customIconFavorite(month.toString(), "Tháng"),
        customIconFavorite(day.toString(), "Ngày"),
      ],
    );
  }

  Widget customIconFavorite(String text, String typeDate) {
    return Column(
      children: [
        Stack(
          children: [
            Icon(
              Icons.favorite,
              color: Colors.pink[400],
              size: sizeH * 0.07,
            ),
            Positioned(
              top: sizeH * 0.022,
              left: sizeW * 0.054,
              child: Text(
                text,
                style: AppStyle.h2,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        Text(
          typeDate,
          style: AppStyle.h3,
        ),
      ],
    );
  }
}
