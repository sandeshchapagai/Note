import 'package:flutter/material.dart';
import 'package:notes/Home/home.dart';
import 'package:provider/provider.dart';

import '../main.dart';
class Add_screen extends StatefulWidget {
  final Item? editItem; // Accept an existing item for editing

  const Add_screen({Key? key, this.editItem}) : super(key: key);

  @override
  State<Add_screen> createState() => _Add_screenState();
}
class Item {
  String description;
  String title;
  DateTime timestamp;
  Item({required this.title, required this.description,required this.timestamp});
  // Convert an Item object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Create an Item object from a JSON map
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
class _Add_screenState extends State<Add_screen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textController1 = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.editItem != null) {
      // If an existing item is provided, pre-fill the text fields with its values
      _textController.text = widget.editItem!.title;
      _textController1.text = widget.editItem!.description;
    }
  }
  @override
  Widget build(BuildContext context) {
    final dataModel = Provider.of<DataModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(237, 233, 157, 1)
        ,
        title: const Text('Add',
          style: TextStyle(
              color: Colors.black
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Title'),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:const BorderSide(
                        color: Colors.yellow,
                        width: 100
                    ),
                  ),
                ),


              ),
            ),
            const Text('Description'),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _textController1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:const BorderSide(
                          color: Colors.yellow,
                          width: 100
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.green,
              ),
              onPressed: () async {
                String title = _textController.text;
                String description = _textController1.text;
                // timestamp: DateTime.now();
                if (title.isNotEmpty && description.isNotEmpty) {
                  if (widget.editItem != null) {
                    // If editing, update the existing item
                    final newItem = Item(title: title, description: description,timestamp: DateTime.timestamp());
                    dataModel.updateItem(widget.editItem!, newItem); // Update the item
                  } else {
                    // If adding a new item, create a new one
                    final item = Item(title: title, description: description,timestamp: DateTime.timestamp());
                    dataModel.addItem(item);
                  }
                  Navigator.pop(context);
                }
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),


          ],
        ),
      ),
    );
  }
}

