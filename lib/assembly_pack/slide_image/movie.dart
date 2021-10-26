import 'package:flutter_text/init.dart';

class Movie {
  Movie(
      {@required this.date,
      @required this.desc,
      @required this.image,
      @required this.name,
      @required this.price});

  String name; //名称
  String price;
  String desc;
  String date;
  String image;
}
