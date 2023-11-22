import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/Add_Screen/Add_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final dataModel = Provider.of<DataModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(237, 233, 157, 1),
        title: Text('Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dataModel.items.length,
                itemBuilder: (context, index) {
                  final item = dataModel.items[index];
                  final formattedDate = DateFormat.yMMMd().format(DateTime.now());
                  return Center(
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: [
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 18.0,top: 10),
                                child: Text(' $formattedDate'),
                              ),
                            ],
                          ),
                          ListTile(
                            leading: Icon(Icons.album_outlined),
                            title: Text(item.title),
                            subtitle: Text(item.description),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('Edit'),
                                onPressed: () {
                                  // When "Edit" is clicked, navigate to Add_Screen with the data.
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Add_screen(
                                        editItem: item,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                child: const Text('Delete'),
                                onPressed: () {
                                  // Show a confirmation dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirm Delete'),
                                        content: const Text('Do you want to delete this item?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('No'),
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Close the dialog
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Yes'),
                                            onPressed: () {
                                              // Delete the item
                                              dataModel.removeItem(item);
                                              Navigator.of(context).pop(); // Close the dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Add_screen(),
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
