class ImageModel {
  String? image; //图片地址
  String? fileImage; //本地图片
  String overBrowerUrl; //外部浏览器地址
  String insideUrl; //

  ImageModel({this.image, this.overBrowerUrl = '', this.insideUrl = '', this.fileImage});
}
