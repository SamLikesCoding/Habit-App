// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:habit_app/pages/HomePage.dart';
import 'package:habit_app/pages/widgets.dart';
import 'package:simple_animations/simple_animations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 6),
      () => Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => const HomePage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: MirrorAnimation<Color?>(
        tween: ColorTween(
          begin: CupertinoColors.activeBlue,
          end: const Color.fromARGB(255, 0, 187, 255),
        ),
        builder: ((context, child, value) {
          return Container(
            decoration: BoxDecoration(
              color: value,
            ),
            child: child,
          );
        }),
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(seconds: 5),
        child: const Center(
          child: AppTitle(
            value: "Habit",
          ),
        ),
      ),
    );
  }
}
