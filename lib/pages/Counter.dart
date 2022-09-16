// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:habit_app/pages/widgets.dart';

class CounterPage extends StatefulWidget {
  String actkey;
  CounterPage({required this.actkey, Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final String actPTR = "ActivityList";
  TextInputGadget counts = TextInputGadget(
    label: "Today's Score",
    labelSize: 32,
    isNumber: true,
  );
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: SizedBox(
          width: 360,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacers(
                height: 9,
              ),
              counts,
              const Spacers(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      size: 48,
                      color: CupertinoColors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop({});
                    },
                    child: const Icon(
                      CupertinoIcons.check_mark_circled,
                      size: 48,
                      color: CupertinoColors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
