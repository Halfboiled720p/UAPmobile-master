import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class FavoritController extends GetxController {
  var makananList = <dynamic>[].obs;
  var isLoading = true.obs;

  // Fungsi untuk memanggil API dan mendapatkan resep berdasarkan bahan
  Future<void> getResepSarapan(String ingredient) async {
    isLoading(true); // Menandakan mulai loading
    try {
      var response = await http.get(
        Uri.parse('http://www.recipepuppy.com/api/?i=$ingredient&key=YOUR_API_KEY'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        makananList.value = data['results']; // Mengupdate makananList dengan data yang didapat
      } else {
        throw Exception('Gagal memuat resep');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false); // Menandakan loading selesai
    }
  }
}
