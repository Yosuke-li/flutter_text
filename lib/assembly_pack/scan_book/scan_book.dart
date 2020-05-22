import 'package:flutter/material.dart';
import 'package:flutter_text/api/scan_book.dart';
import 'package:flutter_text/model/scan_book.dart';
import 'package:qrscan/qrscan.dart' as scanner;

void main() => runApp(ScanBook());

class ScanBook extends StatefulWidget {
  TextState createState() => TextState();
}

class TextState extends State<ScanBook> {
  String barcode = "";
  ScanBookPModel _scanPBook;        //私人Api
  ScanBookAModel _scanABook;        //阿里Api

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scan barcodes and qr codes'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _scanPBook != null ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('书名： ${_scanPBook.name}'),
                    Text('图书类型： ${_scanPBook.title}'),
                    Text('作者： ${_scanPBook.author}'),
                    Text('出版社： ${_scanPBook.publisher}'),
                    Text('出版时间： ${_scanPBook.publishingTime}'),
                    Text('isbn： ${_scanPBook.isbn}'),
                  ],
                ) : Container(),
              _scanABook != null ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('书名： ${_scanABook.title}'),
                    Text('类型： ${_scanABook.keyword}'),
                    Text('作者： ${_scanABook.author}'),
                    Text('出版社： ${_scanABook.publisher}'),
                    Text('出版时间： ${_scanABook.pubdate}'),
                    Text('isbn： ${_scanABook.isbn}'),
                  ],
                ) : Container(),
              Column(
                children: <Widget>[
                  MaterialButton(
                    onPressed: scan,
                    child: Text("图片条形码"),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                  MaterialButton(
                    onPressed: scanAli,
                    child: Text("图片条形码(阿里)"),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //私人Api扫码
  Future scan() async {
    try {
      String barcode = await scanner.scan();
      ScanBookPModel scanBook = await ScanBookApi().IsbnGetBookDetailP(barcode);
      setState(() {
        _scanPBook = scanBook;
      });
    } on Exception catch (e) {
      if (e == scanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    }
  }

  //阿里云扫图书条形码
  Future scanAli() async {
    try {
      String barcode = await scanner.scan();
      ScanBookAModel scanBook = await ScanBookApi().IsbnGetBookDetailA(barcode);
      setState(() {
        _scanABook = scanBook;
      });
    } on Exception catch (e) {
      if (e == scanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    }
  }
}
