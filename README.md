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

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
## Membuat halaman login pada proyek tugas Flutter.
- Membuat file ```login.dart``` pada folder ```screens``` yang berisi untuk login dan register
``` dart
import 'package:pacil_lib/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:pacil_lib/screens/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color.fromARGB(255, 175, 128, 196),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Cek kredensial
                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                // Untuk menyambungkan Android emulator dengan Django pada localhost,
                // gunakan URL http://10.0.2.2/
                final response = await request.login(
                    "https://nabila-zavira-tugas.pbp.cs.ui.ac.id/auth/login/", {
                  'username': username,
                  'password': password,
                });

                if (request.loggedIn) {
                  String message = response['message'];
                  String uname = response['username'];
                  int id = response['id'];
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(id: id)),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text("$message Selamat datang, $uname.")));
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Gagal'),
                      content: Text(response['message']),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
            SizedBox(height: 20),
            Text(
              'Don`t have an account yet?',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to registration page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrationPage()),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
```
## Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.
 - Membuat ```django-app``` dengan nama ```authentication```
 - Menambahkan ```authentication``` ke `INSTALLED_APPS` pada main project `settings.py`. Lalu menjalankan `pip install django-cors-headers` untuk menginstal library yang dibutuhkan.
- Setelah itu, menambahkan `corsheaders` ke `INSTALLED_APPS`, `corsheaders.middleware.CorsMiddleware`, dan beberapa variabel pada main project `settings.py`. 
```python
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'
```
- Lalu membuat fungsi view untuk login pada file `authentication/views.py`
```py
from django.shortcuts import render

# Create your views here.
from django.shortcuts import render
from django.contrib.auth import authenticate, login as auth_login
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import logout as auth_logout
from django.contrib.auth.models import User


@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # Status login sukses.
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login sukses!",
                "id": user.id,
                # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login gagal, akun dinonaktifkan."
            }, status=401)

    else:
        return JsonResponse({
            "status": False,
            "message": "Login gagal, periksa kembali email atau kata sandi."
        }, status=401)

@csrf_exempt
def logout(request):
    username = request.user.username

    try:
        auth_logout(request)
        return JsonResponse({
            "username": username,
            "status": True,
            "message": "Logout berhasil!"
        }, status=200)
    except:
        return JsonResponse({
        "status": False,
        "message": "Logout gagal."
        }, status=401)

@csrf_exempt
def register(request):
    if request.method == "POST":
        username = request.POST.get('username')
        password = request.POST.get('password')

        new_user = User.objects.create_user(username=username, password=password)
            
        return JsonResponse({
            "status": True,
            "message": "Account created successfully!",
            "user_id": new_user.id,
        }, status=200)
    
    return JsonResponse({
        "status": False,
        "message": "Invalid request method."
    }, status=405)
```
- Lalu pada file `authentication/urls.py` dan menambahkan URL routing terhadap fungsi yang sudah dibuat.
```py
from django.urls import path
from authentication.views import login, logout, register

app_name = 'authentication'

urlpatterns = [
    path('login/', login, name='login'),
    path('logout/', logout, name='logout'),
    path('register/', register, name='register'),
]
```
- Instal package, lalu menggunakan package tersebut dan modifikasi root widget untuk menyediakan CookieRequest library ke semua child widgets dengan menggunakan Provider.
```dart
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:pacil_lib/screens/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
            create: (_) {
                CookieRequest request = CookieRequest();
                return request;
            },
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    home: const LoginPage(),
    ),
    );
  }
}

```

## Membuat model kustom sesuai dengan proyek aplikasi Django.
- Membuat file ```item.dart``` pada folder ```models```
```dart
// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

List<Item> itemFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
    String model;
    int pk;
    Fields fields;

    Item({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String name;
    int amount;
    String description;

    Fields({
        required this.user,
        required this.name,
        required this.amount,
        required this.description,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        amount: json["amount"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "amount": amount,
        "description": description,
    };
}
```
## Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.
- Membuat file bernama ```list_item.dart``` pada folder ```screens```
```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
// TODO: Impor drawer yang sudah dibuat sebelumnya
import 'package:pacil_lib/screens/menu.dart';
import 'package:pacil_lib/widgets/left_drawer.dart';

class ShopFormPage extends StatefulWidget {
 final int id;
  const ShopFormPage({super.key, required this.id});

  @override
  State<ShopFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<ShopFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _amount = 0;
  String _description = "";
  @override
  Widget build(BuildContext context) {
    final int id = widget.id;
    final request = context.watch<CookieRequest>();
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
      drawer: LeftDrawer(id: id),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 175, 128, 196)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                            "https://nabila-zavira-tugas.pbp.cs.ui.ac.id/create-flutter/",
                            jsonEncode(<String, String>{
                              'name': _name,
                              'amount': _amount.toString(),
                              'description': _description,
                              // TODO: Sesuaikan field data sesuai dengan aplikasimu
                            }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Item baru berhasil disimpan!"),
                          ));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage(id: id)),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("Terdapat kesalahan, silakan coba lagi."),
                          ));
                        }
                          }
                    },
                        
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
## Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.
 - Membuat file bernama ```list_item_detail.dart``` pada folder ```screens```
```dart
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
```

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

