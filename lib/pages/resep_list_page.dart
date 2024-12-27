import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ResepListPage extends StatefulWidget {
  final String category;
  final String ingredient;

  const ResepListPage({required this.category, required this.ingredient});

  @override
  _ResepListPageState createState() => _ResepListPageState();
}

class _ResepListPageState extends State<ResepListPage> {
  var makananList = <dynamic>[];
  var isLoading = true;

  // Fungsi untuk memanggil API dan mendapatkan resep berdasarkan bahan
  Future<void> getResep() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await http.get(
        Uri.parse('http://www.recipepuppy.com/api/?i=${widget.ingredient}&key=YOUR_API_KEY'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          makananList = data['results']; // Mengupdate makananList dengan data yang didapat
        });
      } else {
        throw Exception('Gagal memuat resep');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false; // Menandakan loading selesai
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getResep(); // Memanggil API saat halaman pertama kali dimuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Recipes'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: makananList.length,
        itemBuilder: (context, index) {
          var makanan = makananList[index];
          return ListTile(
            title: Text(makanan['title'] ?? 'No Title'),
            subtitle: Text(makanan['ingredients'] ?? 'No Ingredients'),
            onTap: () {
              // Bisa menambahkan aksi tambahan seperti membuka detail resep
            },
          );
        },
      ),
    );
  }
}
