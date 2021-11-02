import 'package:flutter/material.dart';
import 'package:flutter_hive_http/locator.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:get_it/get_it.dart';

import 'package:flutter_hive_http/model/information.dart';
import 'package:flutter_hive_http/page/data_page.dart';
import 'boxes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(InformationAdapter());
  await Hive.openBox<Information>('information');

  setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DataPage(),
    );
  }
}
