class Category {
  String categoryId;
  String name;
  String color;

  Category({
    this.name,
    this.color,
    this.categoryId,
  });

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    name = json['name'];
    color = json['color'];
  }
}

class CategoryList {
  String resultCode;
  String resultMsg;
  String reqId;
  String systemTime;
  List mcategoryList;
  List<Category> categoryList;

  CategoryList({
    this.categoryList,
    this.mcategoryList,
    this.reqId,
    this.resultCode,
    this.resultMsg,
    this.systemTime,
  });

  CategoryList.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultMsg = json['resultMsg'];
    systemTime = json['systemTime'];
    mcategoryList = json['categoryList'];
    reqId = json['reqId'];
  }
}
