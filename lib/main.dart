import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
          // textTheme: Typography(platform: TargetPlatform.iOS).white,
          ),
      color: Colors.black,
      home: Home(),
    );
  }
}
