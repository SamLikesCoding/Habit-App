// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:habit_app/functions/rndkey.dart';
import 'package:habit_app/model/ActivityModel.dart';
import 'package:habit_app/pages/HabitPage.dart';
import 'package:habit_app/pages/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HomeTab(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AppButton(
              child: const AppText(
                value: "Add Habit",
                size: 18,
              ),
              action: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const AddActivityTab(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Tabs
class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Box<ActivityModel>? box;

  @override
  void initState() {
    initAction();
    super.initState();
  }

  initAction() async {
    if (Hive.isBoxOpen("ActivityList")) {
      box = Hive.box("ActivityList");
    } else {
      await Hive.openBox("ActivityList");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 1.5,
        vertical: 32,
      ),
      child: ValueListenableBuilder(
        valueListenable: box!.listenable(),
        builder: (context, value, child) {
          if (box!.isNotEmpty) {
            List<ActivityModel> actlist = box!.values.toList();
            actlist.map(
              (e) {
                log(e.actName);
              },
            );
            return ListView.builder(
              shrinkWrap: true,
              itemCount: actlist.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  log("Tapped on ${actlist[index].actName}");
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => HabitPage(actlist[index].id),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          value: actlist[index].actName,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Spacers(
                height: 90,
              ),
              Center(
                child: AppText(
                  value: "No tasks found",
                  size: 24,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AddActivityTab extends StatefulWidget {
  const AddActivityTab({Key? key}) : super(key: key);
  @override
  State<AddActivityTab> createState() => _AddActivityTabState();
}

class _AddActivityTabState extends State<AddActivityTab> {
  Box<ActivityModel>? box;
  final String actKey = "ActivityList";
  String habitName = "";
  TextInputGadget habitNameField = TextInputGadget(
    label: "New Habit",
    labelSize: 32,
  );

  @override
  void initState() {
    super.initState();
    initActions();
  }

  @override
  void dispose() {
    super.dispose();
    //box!.close();
  }

  initActions() async {
    if (Hive.isBoxOpen(actKey)) {
      box = Hive.box(actKey);
    } else {
      await Hive.openBox(actKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(27.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacers(
                height: 100,
              ),
              // const AppSubTitle(value: "Add new Habit"),
              const Spacers(
                height: 10,
              ),
              SizedBox(
                width: 400,
                child: habitNameField,
              ),
              const Spacers(
                height: 24,
              ),
              AppButton(
                child: const AppText(
                  value: "Add",
                  size: 18,
                ),
                action: () {
                  habitName = habitNameField.value;
                  log("Habit Name : $habitName");
                  habitNameField.clearUp();
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => SelectType(),
                  ).then(
                    (value) {
                      log(value.toString());
                      String key = randomKey(habitName.length);
                      ActivityModel model = ActivityModel(
                        key,
                        habitName,
                        value['isCount'],
                        value['isTime'],
                      );
                      log(" Activity '$habitName' is created!");
                      box!.put(key, model);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
              CupertinoButton(
                child: const AppText(
                  value: "Back",
                  size: 20,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectType extends StatefulWidget {
  SelectType({Key? key}) : super(key: key);
  bool isTime = false;
  bool isCount = false;
  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const AppBoldText(
        value: "Set Habit type",
        color: CupertinoColors.systemBlue,
        size: 24,
      ),
      message: const AppText(
        value: "Set how do you want to monitor or record your habit.",
        size: 18,
        color: CupertinoColors.black,
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            setState(() {
              widget.isTime = !widget.isTime;
            });
          },
          child: AppBoldText(
            value: "Timed Habit",
            size: 15,
            color: widget.isTime
                ? CupertinoColors.systemGreen
                : CupertinoColors.black,
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            setState(() {
              widget.isCount = !widget.isCount;
            });
          },
          child: AppBoldText(
            value: "Counting Habit",
            size: 15,
            color: widget.isCount
                ? CupertinoColors.systemGreen
                : CupertinoColors.black,
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const AppBoldText(
          value: "Done",
          size: 12,
          color: CupertinoColors.activeBlue,
        ),
        onPressed: () {
          Navigator.of(context).pop({
            "isTime": widget.isTime,
            "isCount": widget.isCount,
          });
        },
      ),
    );
  }
}
