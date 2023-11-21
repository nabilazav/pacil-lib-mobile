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

# TUGAS 8

# Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!

- `Navigator.push()`: Metode ini digunakan untuk menambahkan halaman baru ke tumpukan navigasi. Dengan kata lain, halaman saat ini tetap ada dalam tumpukan, dan halaman baru ditambahkan di atasnya.

```dart
  if (item.name == "Tambah Item") {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => const ShopFormPage()));
  }
          
```

- `Navigator.pushReplacement()`: Metode ini menggantikan halaman saat ini dengan halaman baru. Ini berguna ketika Anda ingin mengganti halaman tanpa menyimpannya di tumpukan navigasi.

```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => ShopFormPage()),
);
```

##  Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!

1. **Container**: Widget ini menyediakan kotak yang dapat dikonfigurasi dengan berbagai properti seperti warna, padding, dan sebagainya. Cocok digunakan untuk wadah umum.

2. **Row dan Column**: Digunakan untuk menyusun widget secara horizontal (Row) atau vertikal (Column). Berguna untuk tata letak yang lebih kompleks.

3. **Stack**: Mengatur widget di atas satu sama lain. Misalnya, ketika Anda ingin menempatkan teks di atas gambar.

4. **ListView**: Widget ini digunakan ketika Anda memiliki daftar item yang panjang. Pengguna dapat melakukan scroll untuk melihat semua item.

5. **GridView**: Cocok untuk menampilkan data dalam bentuk grid atau tabel.

# Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!

1. TextFormField untuk Nama Item:
- Tipe Data: String
- Alasan: Digunakan untuk mengambil nama item yang ingin ditambahkan. Validasi dilakukan untuk memastikan input tidak kosong.

2. TextFormField untuk Jumlah:
- Tipe Data: int
- Alasan: Dalam hal ini, kita menggunakan TextFormField tetapi mengonversi nilai input ke dalam tipe data int karena jumlah umumnya adalah angka. Validasi dilakukan untuk memastikan input bukan hanya angka, tetapi juga tidak boleh kosong.

3. TextFormField untuk Deskripsi:
- Tipe Data: String
- Alasan: Untuk mendapatkan deskripsi item yang akan ditambahkan. Validasi dilakukan untuk memastikan input tidak kosong.

- TextFormField: Cocok untuk mengumpulkan input teks dengan kemungkinan validasi.

# Bagaimana penerapan clean architecture pada aplikasi Flutter?

Clean architecture pada Flutter melibatkan pembagian kode menjadi beberapa lapisan, seperti Presentation Layer (UI), Domain Layer (Bisnis Logic), dan Data Layer (Akses Data). Metode ini membantu menjaga kode agar bersih, terstruktur, dan mudah diuji.

# Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)

- Membuat folder baru dengan nama widgets dan file baru dengan nama left_drawer.dart
isi kode ini pada file dan tambahkan pada bagian drawer header
```dart
import 'package:flutter/material.dart';
import 'package:pacil_lib/screens/menu.dart';
import 'package:pacil_lib/screens/pacil_lib_form.dart';
import 'package:pacil_lib/screens/pacil_lib_page.dart';


class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

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
                    builder: (context) => MyHomePage(),
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
                    builder: (context) => const ShopFormPage(),
                  ));
            },
          ),
           ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('Lihat Item'),
            // Bagian redirection ke FragranceFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemListPage(itemList: itemList),
                  ));
            },
          )
        ],
      ),
    );
  }
}
```
- Menambahkan import drawer widget pada file ```menu.dart```
```dart
import 'package:flutter/material.dart';
import 'package:pacil_lib/widgets/left_drawer.dart';
import 'package:pacil_lib/widgets/pacil_lib_card.dart';
```

- Membuat file baru dengan nama pacil_lib_form.dart dan isi dengan kode.
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// TODO: Impor drawer yang sudah dibuat sebelumnya
import 'package:pacil_lib/widgets/left_drawer.dart';
import 'package:pacil_lib/models/pacil_lib_models.dart';

List<Item> itemList = [];

class ShopFormPage extends StatefulWidget {
    const ShopFormPage({super.key});

    @override
    State<ShopFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<ShopFormPage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Form Tambah Item',
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 175, 128, 196),
          foregroundColor: Colors.white,
        ),
        // TODO: Tambahkan drawer yang sudah dibuat di sini
        drawer: const LeftDrawer(),
        body: Form(
        child: SingleChildScrollView(
        ),
      );
    }
}
```
- Membuat variabel baru dengan nama ```_formKey```. Setelah itu, menambahkan ```_formKey``` ke dalam atribut ```key``` pada widget ```Form```
Atribut key untuk handler dari form state, validasi form, dan penyimpanan form.
```dart
...
class _ShopFormPageState extends State<ShopFormPage> {
    final _formKey = GlobalKey<FormState>();
...
```
```dart
...
body: Form(
     key: _formKey,
     child: SingleChildScrollView(),
),
...
```
- Mengisi widget ```Form``` dengan field dengan variabel ```_name```, ```_amount``` dan ```_description```
```dart
class _ShopFormPageState extends State<ShopFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    int _amount = 0;
    String _description = "";
```
- Membuat widget column yang merupakan child dari ```SingleChildScrollView```
```dart
...
body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column()
      ),
...
```
- Membuat widget ```TextFormField``` yang dibungkus oleh ```Padding``` yang merupakan children dari widget ```Column```. Lalu menambahkan ```crossAxisAlignment``` untuk atur alignment children 
```dart
 child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Item",
                    labelText: "Nama Item",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nama tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
```
- Lalu membuat dua ```TextFormField ``` yang dibungkus ```Padding``` yang menjadi child dari ```Column``` untuk ```amount``` dan ```description```
```dart
Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Jumlah",
                    labelText: "Jumlah",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // TODO: Tambahkan variabel yang sesuai
                  onChanged: (String? value) {
                    setState(() {
                      _amount = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Jumlah tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Jumlah harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Deskripsi",
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      // TODO: Tambahkan variabel yang sesuai
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
```
- Mmebuat tombol yang dibungkus ```Padding``` serta ```Align``` yang merupakan child dari ```Column``` untuk membuat pop-up. Lalu tambahkan fungsi ```showDialog()``` di bagian ```onPressed()```. Setelah itu, munculkan ```AlertDialog``` dan menambahkan fungsi reset form
```dart
   Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color.fromARGB(255, 175, 128, 196)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Item newItem = Item(
                          name: _name,
                          amount: _amount,
                          description: _description,
                        );
                        itemList.add(newItem);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Item berhasil tersimpan'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                  // TODO: Munculkan value-value lainnya
                                    Text('Nama: $_name'),
                                    Text('Jumlah: $_amount'),
                                    Text('Deskripsi: $_description'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      _formKey.currentState!.reset();
                      }
                    },
                    
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                ),
              ),
```
- Setelah itu membuat file baru yang bernama ```pacil_lib_card.dart``` pada folder ```widgets```. Lalu memindahkan isi widget ```ShopItem``` pada ```menu,dart```ke file ```pacil_lib_card.cart```
```dart
import 'package:flutter/material.dart';
import 'package:pacil_lib/screens/pacil_lib_form.dart';
import 'package:pacil_lib/screens/pacil_lib_page.dart';


class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}


class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
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
- Menambahkan kode di file ```pacil_lib_card.dart``` pada widget ```ShopItem``` agar bisa navigasi ke route lain
```dart
 // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text("Kamu telah menekan tombol ${item.name}!")));
            if (item.name == "Tambah Item") {
            // TODO: Gunakan Navigator.push untuk melakukan navigasi ke MaterialPageRoute yang mencakup ShopFormPage.
             Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ShopFormPage()));
          }
          
        },
```
- Membuat file baru dengan nama ```pacil_lib_page``` untuk memunculkan item yang ditambahkan. File tersbut berisi kode
```dart
import 'package:flutter/material.dart';
import 'package:pacil_lib/models/pacil_lib_models.dart';
import 'package:pacil_lib/widgets/left_drawer.dart';

class ItemListPage extends StatelessWidget {
  final List<Item> itemList; 

  const ItemListPage({Key? key, required this.itemList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Item'),
        backgroundColor: const Color.fromARGB(255, 175, 128, 196),
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: ListTile(
              title: Text(itemList[index].name),
              subtitle: Text('Jumlah: ${itemList[index].amount}'),
              onTap: () {
                // Menampilkan popup dengan informasi barang yang di-klik
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(itemList[index].name),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Jumlah: ${itemList[index].amount}'),
                          Text('Deskripsi: ${itemList[index].description}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Tutup'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
```

- Membuat folder dengan nama ```screens``` pada folder ```lib```. Lalu memindahkan file ```menu.dart``` dan ```pacil_lib_form.dart``` dan ```pacil_lib_page``` ke folder ```screens```
- Membuat folder baru dengan nama ```models``` pada folder ```lib```. Lalu membuat file baru dengan nama ```pacil_lib_models.dart``` isi file dengan kode
```dart
class Item {
  String name;
  int amount;
  String description;

  Item({
    required this.name,
    required this.amount,
    required this.description,
  });
}
```


# Tugas 9
 ## Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?
 Ya, kita dapat melakukan pengambilan data JSON tanpa membuat model terlebih dahulu, disebut sebagai "parsing" data JSON. Dalam beberapa kasus, terutama jika struktur data sederhana, tidak perlu membuat model terlebih dahulu. Namun, jika struktur data kompleks, membuat model dapat membantu dalam memahami dan mengelola data dengan lebih baik.

 ## Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
 - CookieRequest merupakan sebuah objek atau kelas yang digunakan untuk mengelola permintaan HTTP yang melibatkan cookies.
- Instance CookieRequest dibagikan ke semua komponen dalam aplikasi Flutter aagar dapat membantu dalam menjaga konsistensi dan integritas data cookies di seluruh aplikasi. Misalnya, jika ingin melacak sesi pengguna atau informasi autentikasi melalui cookies, instance yang dibagikan ke semua komponen di aplikasi akan memastikan bahwa informasi ini dapat diakses dan diperbarui dengan konsisten di seluruh aplikasi.

 ## Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.
 Mekanisme nya melibatkan membuat permintaan HTTP (biasanya dengan menggunakan paket seperti http) untuk mendapatkan data JSON dari server. Setelah menerima respons, data JSON diurai dan dimodelkan ke dalam objek yang sesuai. Widget Flutter kemudian menggunakan objek ini untuk membangun interface pengguna.

 ## Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
 Mekanisme umumnya melibatkan formulir input pengguna di Flutter yang dikirimkan ke backend Django melalui permintaan HTTP. Django akan memproses dan mengautentikasi data tersebut. Jika autentikasi berhasil, server memberikan token atau sesi, yang kemudian dapat disimpan di Flutter dan digunakan untuk permintaan selanjutnya. Ketika token kadaluwarsa, proses autentikasi perlu diulang.

 ## Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.
- AppBar: Menampilkan judul "Item".
- LeftDrawer: Drawer di sebelah kiri dengan opsi navigasi.
- FutureBuilder: membuat widget yang bergantung pada hasil operasi asynchronous fetchItem.
- CircularProgressIndicator: Ditampilkan saat data sedang diambil.
- ListView.builder: Membangun daftar item dengan model Item.
- MaterialApp: Widget utama untuk aplikasi Flutter.
- TextField: Input untuk username.
- TextField: Input untuk password (bersifat tersembunyi).
- ElevatedButton: Tombol untuk melakukan login.
- SnackBar: Pesan notifikasi setelah login berhasil atau gagal.
- Scaffold: Halaman utama dengan app bar, drawer dan login.
- LeftDrawer: Drawer di sebelah kiri dengan opsi navigasi.
- GridView.count: Menampilkan item dalam grid.
- ShopCard: Card untuk setiap item dalam grid.
- Drawer: Menyediakan menu navigasi ke halaman utama, tambah item, dan lihat item.
- String name: Nama item.
- IconData icon: Ikon yang mewakili item.
- Color color: Warna latar belakang item.
- Material: Menyediakan latar belakang untuk card.
- InkWell: Membuat card responsif terhadap sentuhan.
- Icon: Menampilkan ikon untuk item.
- Text: Menampilkan nama item.
- Scaffold: Halaman formulir untuk menambahkan item.
- Form: Widget untuk menangani formulir.
- TextFormField: Input untuk nama, jumlah, dan deskripsi item.
- ElevatedButton: Tombol untuk menyimpan item baru.
- Provider: Membungkus aplikasi dengan CookieRequest sebagai provider.
- Container: Widget umum untuk mengelola tata letak dan dekorasi.
- Column dan Row: Digunakan untuk mengatur widget secara vertikal (Column) atau horizontal (Row).
- Http Package (http): Digunakan untuk melakukan permintaan HTTP ke server.
- Navigator: Mengelola navigasi antar halaman dalam aplikasi Flutter.
- Form dan TextFormField: Untuk mengelola formulir dan input teks




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

