import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hive_http/model/information.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_hive_http/boxes.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late Future<Data> futureData;

  void initState() {
    super.initState();
    futureData = fetchData();
  }

  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var box = Boxes.getInformation();

    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data from Json'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<Data>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var information = Information(
                name: snapshot.data!.name,
                age: snapshot.data!.age,
                count: snapshot.data!.count,
              );
              box.put('information', information);
              print(box.get('information')!.name);
              print(box.get('information')!.age);
              print(box.get('information')!.count);
              return Text(
                  '${box.get('information')!.name}\n ${box.get('information')!.age} ${box.get('information')!.count}');
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<Data> fetchData() async {
  final response =
      await http.get(Uri.parse('https://api.agify.io/?name=shoot'));

  if (response.statusCode == 200) {
    return Data.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class Data {
  final String name;
  final int age;
  final int count;

  Data({
    required this.name,
    required this.age,
    required this.count,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'],
      age: json['age'],
      count: json['count'],
    );
  }
}
