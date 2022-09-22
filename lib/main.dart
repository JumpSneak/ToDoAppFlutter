import 'package:flutter/material.dart';
import 'package:todolist/pages/homescreen.dart';
import 'package:todolist/pages/create.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

List<String> tasklisttexts = [];

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("mybox");
  final taskbox = Hive.box("mybox");
  //taskbox.delete('text');
  //tasklisttexts = ["hi", "great", "wassup", "lol"];
  if(taskbox.get('text') != null) {
    print("Using stored tasklist");
    tasklisttexts = taskbox.get('text');
  }
  taskbox.put('text', tasklisttexts);
  print(tasklisttexts);
  print("####1");

  runApp(MaterialApp(
    initialRoute: "/homescreen",
    routes: {
      "/homescreen": (context) => Home(),
      "/create": (context) => Create(),
    },
  ));
}

