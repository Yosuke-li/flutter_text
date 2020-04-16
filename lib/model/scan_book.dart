//私人
class ScanBookPModel {
  String code;
  String isbn;
  String splitIsbn;
  String name;
  String englishName;
  String title;
  String seriesName;
  int copiesCount;
  String cip;
  String clc;
  String author;
  String introduction;
  String content;
  String publisher;
  String publishingTime;
  String publishingAddress;
  String edition;
  String print;
  String score;
  String translate;
  String editor;
  String illustrator;
  String pageCount;
  String folio;
  String size;
  String weight;
  String price;
  String image;

  ScanBookPModel({
    this.print,
    this.size,
    this.name,
    this.image,
    this.title,
    this.author,
    this.code,
    this.isbn,
    this.splitIsbn,
    this.englishName,
    this.seriesName,
    this.copiesCount,
    this.cip,
    this.clc,
    this.introduction,
    this.content,
    this.publisher,
    this.publishingTime,
    this.publishingAddress,
    this.edition,
    this.score,
    this.translate,
    this.editor,
    this.illustrator,
    this.pageCount,
    this.folio,
    this.price,
  });

  ScanBookPModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    isbn = json['isbn'];
    splitIsbn = json['splitIsbn'];
    name = json['name'];
    englishName = json['englishName'];
    title = json['title'];
    seriesName = json['seriesName'];
    copiesCount = json['copiesCount'];
    cip = json['cip'];
    clc = json['clc'];
    author = json['author'];
    introduction = json['introduction'];
    content = json['content'];
    publisher = json['publisher'];
    publishingTime = json['publishingTime'];
    publishingAddress = json['publishingAddress'];
    edition = json['edition'];
    print = json['print'];
    score = json['score'];
    translate = json['translate'];
    editor = json['editor'];
    illustrator = json['illustrator'];
    pageCount = json['pageCount'];
    folio = json['folio'];
    size = json['size'];
    weight = json['weight'];
    price = json['price'];
    image = json['image'];
  }
}

//阿里
class ScanBookAModel {
  String title;
  String subtitle;
  String pic;
  String author;
  String summary;
  String publisher;
  String pubplace;
  String pubdate;
  int page;
  String price;
  String binding;
  String isbn;
  String isbn10;
  String keyword;
  String edition;
  String impression;
  String language;
  String format;
  String classA;

  ScanBookAModel({
    this.title,
    this.author,
    this.isbn,
    this.publisher,
    this.edition,
    this.price,
    this.page,
    this.format,
    this.binding,
    this.classA,
    this.impression,
    this.isbn10,
    this.keyword,
    this.language,
    this.pic,
    this.pubdate,
    this.pubplace,
    this.subtitle,
    this.summary
  });

  ScanBookAModel.fromJson(Map<String, dynamic> json) {
    isbn = json['isbn'];
    title = json['title'];
    author = json['author'];
    publisher = json['publisher'];
    edition = json['edition'];
    subtitle = json['subtitle'];
    pic = json['pic'];
    summary = json['summary'];
    pubplace = json['pubplace'];
    pubdate = json['pubdate'];
    page = json['page'];
    binding = json['binding'];
    isbn10 = json['isbn10'];
    keyword = json['keyword'];
    price = json['price'];
    edition = json['edition'];
    impression = json['impression'];
    language = json['language'];
    format = json['format'];
    classA = json['class'];
  }
}
