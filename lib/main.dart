import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Add_Screen/Add_screen.dart';
import 'Home/home.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => DataModel()),
          ],
      child:MyApp()
      )
      );
}
class DataModel extends ChangeNotifier {
  List<Item> items = [];
  void addItem(Item item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    items.remove(item);
    notifyListeners();
  }
  String title = '';
  String description = '';

  void updateItem(Item oldItem, Item newItem) {
    final index = items.indexOf(oldItem);
    if (index != -1) {
      items[index] = newItem;
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
