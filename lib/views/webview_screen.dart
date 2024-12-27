import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  final String title;

  const WebViewScreen({required this.url, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: WebviewScaffold(
        url: url, // Ganti dengan URL yang diinginkan
        appBar: AppBar(
          title: Text(title),
        ),
        withZoom: true, // Menampilkan opsi zoom
        withLocalStorage: true, // Mengaktifkan penyimpanan lokal
        hidden: true, // Sembunyikan WebView saat halaman dimuat
        initialChild: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}