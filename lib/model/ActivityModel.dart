// ignore_for_file: file_names
import 'package:hive/hive.dart';
part 'ActivityModel.g.dart';

@HiveType(typeId: 0)
class ActivityModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String actName;

  @HiveField(2)
  bool isCount;

  @HiveField(3)
  bool isTimed;

  @HiveField(4)
  List<dynamic> record = [];

  ActivityModel(
    this.id,
    this.actName,
    this.isCount,
    this.isTimed,
  );
}
