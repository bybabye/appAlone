import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class SettingDatePage extends StatefulWidget {
  const SettingDatePage({Key? key}) : super(key: key);

  @override
  _SettingDatePageState createState() => _SettingDatePageState();
}

class _SettingDatePageState extends State<SettingDatePage> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scroll Date Picker Example"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ScrollDatePicker(
              minimumYear: 2010,
              maximumYear: 2050,
              selectedDate: _selectedDate,
              locale: DatePickerLocale.en_us,
              options: const DatePickerOptions(),
              onDateTimeChanged: (DateTime value) {
                setState(() {
                  _selectedDate = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
