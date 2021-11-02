import 'package:hive/hive.dart';

part 'information.g.dart';

@HiveType(typeId: 0)
class Information extends HiveObject {
  Information({
    required this.name,
    required this.age,
    required this.count,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  int count;
}
