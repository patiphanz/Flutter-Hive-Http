import 'package:flutter_hive_http/boxes.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<Boxes>(() => Boxes());
}
