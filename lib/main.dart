// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:habit_app/model/ActivityModel.dart';
import 'package:habit_app/pages/WelcomeScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ActivityModelAdapter());
  await Hive.openBox<ActivityModel>("ActivityList");
  runApp(const startApp());
}

class startApp extends StatelessWidget {
  const startApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 187, 255),
        brightness: Brightness.light,
      ),
      home: WelcomeScreen(),
    );
  }
}
