import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_generator/Screens/image_generator/imageGenerator.dart';
import 'Constants/color.dart';
import 'dart:io' show Platform;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: Platform.isAndroid
          ? ["ca-app-pub-9920930529636149~2533626623"]
          : ["ca-app-pub-9920930529636149~6371841427"]));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kDarkModeBgColor,
          colorScheme: ColorScheme.fromSeed(seedColor: btnColor),
          useMaterial3: true,
        ),
        home: ImageGenerator());
  }
}
