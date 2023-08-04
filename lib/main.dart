import 'package:elm/service/local/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'constant/value.dart';
import 'mvc/view/page/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  token = await SharedPref().getValue('token') ?? '';
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((value) => runApp(MyApp()));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Home(),
    );
  }
}

///reduce app size command
//flutter build apk --release --target-platform android-arm64
//flutter build apk --split-per-abi
//flutter build apk --target-platform android-arm64 --analyze-size
