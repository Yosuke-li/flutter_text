import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookShelf extends StatefulWidget {

  @override
  _BookShelfState createState() => _BookShelfState();
}

class _BookShelfState extends State<BookShelf> {

  @override
  void initState() {
    super.initState();
    onRead();
  }

  void onRead() async {
    final bytes = await rootBundle.load('assets/long14.epub');
    final book = await EpubReader.readBook(bytes.buffer.asUint8List());
    print(book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('书架'),
      ),
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}