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

class ContList {
  String contId;
  String name;
  String pic;
  String link;
  String linkType;
  String cornerLabel;
  String cornerLabelDesc;
  String forwordType;
  String videoType;
  String duration;
  String liveStatus;
  String liveStartTime;
  String praiseTimes;
  String adExpMonitorUrl;
  String coverVideo;
  Map mNodeInfo;

  NodeInfo nodeInfo;

  ContList({
    this.contId,
    this.name,
    this.pic,
    this.link,
    this.linkType,
    this.cornerLabel,
    this.cornerLabelDesc,
    this.forwordType,
    this.videoType,
    this.duration,
    this.liveStatus,
    this.liveStartTime,
    this.praiseTimes,
    this.adExpMonitorUrl,
    this.coverVideo,
    this.nodeInfo,
    this.mNodeInfo,
  });

  ContList.fromJson(Map<String, dynamic> json) {
    contId = json['contId'];
    name = json['name'];
    pic = json['pic'];
    linkType = json['linkType'];
    link = json['link'];
    cornerLabel = json['cornerLabel'];
    cornerLabelDesc = json['cornerLabelDesc'];
    forwordType = json['forwordType'];
    videoType = json['videoType'];
    duration = json['duration'];
    liveStatus = json['liveStatus'];
    liveStartTime = json['liveStartTime'];
    praiseTimes = json['praiseTimes'];
    coverVideo = json['coverVideo'];
    mNodeInfo = json['nodeInfo'];
  }
}

class NodeInfo{
  String nodeId;
  String name;
  String logoImg;

  NodeInfo({
    this.nodeId,
    this.name,
    this.logoImg,
  });

  NodeInfo.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeId'];
    name = json['name'];
    logoImg = json['logoImg'];
  }
}