import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pacil_lib/models/item.dart';
import 'package:pacil_lib/screens/list_item_detail.dart';
import 'package:pacil_lib/widgets/left_drawer.dart';

class ItemPage extends StatefulWidget {
  final int id;
  const ItemPage({Key? key, required this.id}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Future<List<Item>> fetchItem() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    final int id = widget.id;
    var url = Uri.parse('https://nabila-zavira-tugas.pbp.cs.ui.ac.id/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Item> list_item = [];
    for (var d in data) {
      if (d != null && d['fields']['user'] == id) {
        list_item.add(Item.fromJson(d));
      }
    }
    return list_item;
  }

  @override
  Widget build(BuildContext context) {
  final int id = widget.id;
  double screenWidth = MediaQuery.of(context).size.width;

      int crossAxisCount;
      if (screenWidth > 1200) {
          crossAxisCount = 3;
      } else if (screenWidth > 600) {
          crossAxisCount = 2;
      } else {
          crossAxisCount = 1;
      }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Item'),
            backgroundColor: const Color.fromARGB(255, 175, 128, 196),
        foregroundColor: Colors.white,
        ),
        drawer: LeftDrawer(id: id),
        body: FutureBuilder(
            future: fetchItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data item.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1 / 0.6,
                          ),
                      itemCount: snapshot.data!.length,
                       itemBuilder: (_, index) {
                            Item item = snapshot.data![index];
                            return InkWell (
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetailPage(item: item),
                                  ),
                                );
                              },
                               child: Card(
                                  child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                              Text(
                                                  "${snapshot.data![index].fields.name}",
                                                  style: const TextStyle(
                                                      fontSize: 25.0,
                                                      fontWeight: FontWeight.bold,
                                                  ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text("${snapshot.data![index].fields.description}"),
                                              const SizedBox(height: 10),
                                              Text("${snapshot.data![index].fields.amount}")
                                           ],
                                      ),
                                  ),
                              ),

                            );
                
                          },
                      );
                  }
              }
            }
          ),
      );
  }

}