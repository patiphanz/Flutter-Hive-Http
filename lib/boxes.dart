import 'package:hive/hive.dart';
import 'package:flutter_hive_http/model/information.dart';

class Boxes {
  Box<Information> getInformation() => Hive.box<Information>('information');
}
