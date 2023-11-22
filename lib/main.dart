import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Add_Screen/Add_screen.dart';
import 'Home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final List<Item> items = await getData();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => DataModel()),
          ],
      child:const MyApp()
      )
      );
}
Future<void> saveData(List<Item> items) async {
  final prefs = await SharedPreferences.getInstance();
  final itemListJson = items.map((item) => item.toJson()).toList();
  await prefs.setString('itemList', json.encode(itemListJson));
}

Future<List<Item>> getData() async {
  final prefs = await SharedPreferences.getInstance();
  final itemListJson = prefs.getString('itemList');
  if (itemListJson != null) {
    final itemList = (json.decode(itemListJson) as List)
        .map((itemMap) => Item.fromJson(itemMap))
        .toList();
    return itemList;
  }
  return [];
}
class DataModel extends ChangeNotifier {
  List<Item> items = [];
  void addItem(Item item) {
    items.add(item);
    saveData(items);
    notifyListeners();
  }

  void removeItem(Item item) {
    items.remove(item);
    saveData(items);
    notifyListeners();
  }
  String title = '';
  String description = '';

  void updateItem(Item oldItem, Item newItem) {
    final index = items.indexOf(oldItem);
    if (index != -1) {
      items[index] = newItem;
      saveData(items);
      notifyListeners();
    }
  }


}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
class Item {
  String description;
  String title;
  DateTime timestamp;

  Item({
    required this.title,
    required this.description,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}