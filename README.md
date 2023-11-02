# pacil_lib

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# TUGAS 7

## Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?

- Stateless widget adalah widget yang tidak memiliki keadaan internal (state). Jadi, setelah widget ini dibuat, tampilan atau kontennya tetap tidak berubah. Stateless widget cocok untuk bagian interface pengguna yang tidak perlu diperbarui secara dinamis, dan kontennya tidak akan berubah selama widget tersebut ada.
Contoh penggunaan: teks statis, ikon, gambar, tombol yang tidak memerlukan perubahan status.

- Stateful widget adalah widget yang memiliki keadaan internal (state). Jadi dapat memperbarui tampilan atau konten mereka ketika keadaan berubah.
Stateful widget cocok untuk bagian interface pengguna yang memerlukan perubahan dinamis, seperti input pengguna, atau tampilan yang berubah seiring waktu. Ketika ada perubahan dalam keadaan internal, stateful widget akan me-rebuild diri mereka sendiri untuk mencerminkan perubahan tersebut. Hal ini memungkinkan adanya perubahan dalam tampilan aplikasi.

## Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.

- MaterialApp adalah widget yang digunakan untuk menginisialisasi aplikasi Flutter. MaterialApp mendefinisikan tema aplikasi dan berfungsi sebagai root widget dari aplikasi.

- MyHomePage adalah widget yang merupakan halaman utama dari aplikasi. MyHomePage adalah stateless widget yang digunakan untuk menampilkan daftar item toko.

- Scaffold adalah widget yang memberikan kerangka dasar untuk halaman dengan app bar dan body. Scaffold digunakan untuk mengelola tata letak dasar halaman.

- AppBar adalah widget yang digunakan untuk menampilkan bar atas aplikasi dengan judul.

- Column adalah widget yang digunakan untuk menampilkan children secara vertikal.

- GridView.count adalah widget yang digunakan untuk menampilkan daftar item dalam tata letak grid dengan jumlah kolom yang ditentukan.

- ShopCard adalah custom stateless widget yang digunakan untuk menampilkan setiap item toko dalam tampilan kartu. Ini juga merespons sentuhan pengguna.

- ShopItem adalah class data yang digunakan untuk merepresentasikan item toko dengan nama dan ikon.

- Icon adalah widget yang digunakan untuk menampilkan ikon.

- Text adalah widget yang digunakan untuk menampilkan teks.

- InkWell adalah widget yang memberikan respons ketika ditekan.

- ScaffoldMessenger digunakan untuk menampilkan SnackBar saat item toko diklik.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial)
- Membuat project Flutter baru dengan nama pacil_lib, kemudian masuk ke dalam folder pacil_lib lalu
``` 
flutter create pacil_lib
cd pacil_lib
```
- Membuat file baru bernama menu.dart pada direktori pacil_lib/lib, tambahkan import 
```import 'package:flutter/material.dart'; ``` dan ```import 'package:pacil_lib/menu.dart';```
- Pada file main.dart, diisi dengan kode
``` dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    home: MyHomePage(),
    );
  }
}
```
- Pada file menu.dart, mengubah sifat widget halaman dari stateful menjadi stateless, pada bagian ```({super.key, required this.title}) menjadi ({Key? key}) : super(key: key);``` Hapus final String title; sampai bawah serta tambahkan Widget build dengan kode seperti ini
```dart
class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);
    
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping List',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0), 
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                
                child: Text(
                  'PBP Shop', 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item) {
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}
```

- Setelah mengubah sifat widget halaman menu menjadi stateless, menambahkan teks dan card untuk memperlihatkan barang yang dijual, define tipe pada list
```dart
class ShopItem {
  final String name;
  final IconData icon;

  ShopItem(this.name, this.icon);
}
```
- Setelah itu dibawah kode ```MyHomePage({Key? key}) : super(key: key);``` menambahkan barang-barang yang dijual (nama, harga, dan icon barang tersebut).
```dart
final List<ShopItem> items = [
    ShopItem("Lihat Item", Icons.checklist),
    ShopItem("Tambah Item", Icons.add_shopping_cart),
    ShopItem("Logout", Icons.logout),
];
```

- Membuat widget stateless baru untuk menampilkan card.
```dart
class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```


