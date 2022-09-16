// ignore_for_file: file_names, must_be_immutable
import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:habit_app/model/ActivityModel.dart';
import 'package:habit_app/pages/widgets.dart';

import 'Counter.dart';

class HabitPage extends StatefulWidget {
  String actKey;
  HabitPage(this.actKey, {Key? key}) : super(key: key);

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  List<Widget> pageButtons = [];
  Box<ActivityModel>? box;
  ActivityModel? activityModel;
  final String actKey = "ActivityList";

  @override
  void initState() {
    super.initState();
    initActions();
    activityModel = box!.get(widget.actKey);
    if (activityModel!.isTimed) {
      pageButtons.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                child: GlassContainer(
                  child: const Icon(
                    CupertinoIcons.timer,
                    color: CupertinoColors.white,
                  ),
                ),
              ),
              const Spacers(
                width: 18,
              ),
              const AppText(
                value: "Do timing!",
                size: 18,
              ),
            ],
          ),
        ),
      );
    }
    if (activityModel!.isCount) {
      pageButtons.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => CounterPage(
                      actkey: activityModel!.id,
                    ),
                  ),
                ),
                child: GlassContainer(
                  child: const Icon(
                    CupertinoIcons.control,
                    color: CupertinoColors.white,
                  ),
                ),
              ),
              const Spacers(
                width: 18,
              ),
              const AppText(
                value: "Do counting!",
                size: 18,
              ),
            ],
          ),
        ),
      );
    }
    pageButtons.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const AppText(
                      value: "Are you sure",
                      size: 14,
                      color: CupertinoColors.black,
                    ),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () {
                          log("deleted");
                          Navigator.of(context).pop();
                          deleteAction();
                          Navigator.of(context).pop();
                        },
                        child: const AppBoldText(
                          value: "Yes",
                          size: 12,
                          color: CupertinoColors.black,
                        ),
                      )
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const AppBoldText(
                        value: "No",
                        size: 12,
                        color: CupertinoColors.black,
                      ),
                    ),
                  ),
                );
              },
              child: GlassContainer(
                child: const Icon(
                  CupertinoIcons.delete,
                  color: CupertinoColors.white,
                ),
              ),
            ),
            const Spacers(
              width: 18,
            ),
            const AppText(
              value: "Delete Habit",
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  initActions() async {
    if (Hive.isBoxOpen(actKey)) {
      box = Hive.box(actKey);
    } else {
      await Hive.openBox(actKey);
    }
  }

  deleteAction() {
    box!.delete(widget.actKey);
    log("Activity Deleted");
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32.0,
          horizontal: 12.5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBoldText(
              value: activityModel!.actName,
            ),
            Column(
              children: pageButtons,
            ),
            CupertinoButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const AppText(
                value: "Back",
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
