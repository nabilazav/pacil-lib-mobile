import 'package:flutter/material.dart';
import 'package:pacil_lib/screens/list_item.dart';
import 'package:pacil_lib/screens/menu.dart';
import 'package:pacil_lib/screens/list_item_form.dart';


class LeftDrawer extends StatelessWidget {
  final int id;
  const LeftDrawer({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // TODO: Bagian drawer header
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 175, 128, 196),
                ),
                child: Column(
                  children: [
                    Text(
                      'Pacil Library',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Text(
                    "Catat seluruh keperluan belanjamu di sini!",
                    style: TextStyle(
                      fontSize: 15,      // Ukuran font 15
                      color: Colors.white,  // Warna teks putih
                      fontWeight: FontWeight.normal,  // Weight biasa
                    ),
                    textAlign: TextAlign.center, // Center alignment
                  )
                  ],
                ),
              ),
          
          // TODO: Bagian routing
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(id:id),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Tambah Item'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              /*
              TODO: Buatlah routing ke ShopFormPage di sini,
              setelah halaman ShopFormPage sudah dibuat.
              */
               Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ShopFormPage(id:id),
                  ));
            },
          ),
           ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('Lihat Item'),
            // Bagian redirection ke FragranceFormPage
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ItemPage(id: id)),
              );
            },
          )
        ],
      ),
    );
  }
}