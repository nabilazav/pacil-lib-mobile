import 'package:flutter/material.dart';
import 'package:pacil_lib/models/item.dart';

class ItemDetailPage extends StatelessWidget {
  
  final Item item;

  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.fields.name),
        backgroundColor: const Color.fromARGB(255, 175, 128, 196),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${item.fields.name}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('Amount: ${item.fields.amount}'),
                    const SizedBox(height: 10),
                    Text('Description: ${item.fields.description}'),
                  ],
                ),
              ),
            ),
        ),
      )
    );
  }
}