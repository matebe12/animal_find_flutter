import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindScreenListView extends StatefulWidget {
  @override
  _FindScreenListViewState createState() => _FindScreenListViewState();
}

class _FindScreenListViewState extends State<FindScreenListView> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              '설정',
            ),
          ],
        ),
        elevation: 0.1,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          SwitchListTile(
              value: status,
              title: Text('어두운모드'),
              onChanged: (val) {
                setState(() {
                  status = val;
                  if (Get.isDarkMode)
                    Get.changeThemeMode(ThemeMode.light);
                  else
                    Get.changeThemeMode(ThemeMode.dark);
                });
              })
          
        ],
      ),
    );
  }
}
