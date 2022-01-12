import 'package:flutter/material.dart';
import 'package:flutter_text/utils/datetime_utils.dart';
import 'package:flutter_text/utils/utils.dart';

final String READER_IMAGE_URL = 'http://statics.zhuishushenqi.com';
final String READER_CHAPTER_URL = 'http://chapterup.zhuishushenqi.com/chapter/';

class BookResult {
  int total;
  List<Books> books;

  bool ok;
  int today;

  /// 书评
  List<BookReviews> reviews;

  ChapterInfo chapter;

  /// 书单
  List<BookList> bookLists;

  /// 书单
  BookList bookList;

  /// 搜索热词
  List<SearchHotWords> searchHotWords;

  /// 搜索热词
  List<String> hotWords;

  /// 搜索热词
  List<SearchHotWords> newHotWords;

  /// 短评
  List<DocsBean> docs;

  /// 讨论
  List<Post> posts;

  List<Tag> tags;

  static BookResult fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookResult bBean = BookResult();
    bBean.total = map['total'];
    bBean.books = List()
      ..addAll((map['books'] as List ?? []).map((o) => Books.fromJson(o)));
    bBean.bookLists = List()
      ..addAll(
          (map['bookLists'] as List ?? []).map((o) => BookList.fromMap(o)));
    bBean.bookList = BookList.fromMap(map['bookList']);
    bBean.ok = map['ok'];
    bBean.today = map['today'];
    bBean.reviews = List()
      ..addAll(
          (map['reviews'] as List ?? []).map((o) => BookReviews.fromMap(o)));
    bBean.chapter = ChapterInfo.fromMap(map['chapter']);
    bBean.docs = List()
      ..addAll((map['docs'] as List ?? []).map((o) => DocsBean.fromMap(o)));
    bBean.posts = List()
      ..addAll((map['posts'] as List ?? []).map((o) => Post.fromMap(o)));
    bBean.tags = List()
      ..addAll((map['data'] as List ?? []).map((o) => Tag.fromMap(o)));

    bBean.hotWords = List()
      ..addAll((map['hotWords'] as List ?? []).map((o) => o.toString()));
    bBean.newHotWords = List()
      ..addAll((map['newHotWords'] as List ?? [])
          .map((o) => SearchHotWords.fromMap(o)));
    bBean.searchHotWords = List()
      ..addAll((map['searchHotWords'] as List ?? [])
          .map((o) => SearchHotWords.fromMap(o)));

    return bBean;
  }

  Map toJson() => {
    "total": total,
    "bookLists": bookLists,
    "bookList": bookList,
    "books": books,
    "today": today,
    "reviews": reviews,
    "chapter": chapter,
    "ok": ok,
    "docs": docs,
    "tags": tags,
  };
}

class Books {
  /// 小说ID
  String id;

  /// 长简介
  String longIntro;

  /// 短简介
  String shortIntro;

  /// 小说作者
  String author;

  String majorCate;
  String majorCateV2;
  String minorCate;
  String minorCateV2;

  /// 名称
  String title;

  /// 封面图片
  String cover;
  String creator;
  int starRatingCount;

  /// 评分信息
  List<StarRatings> starRatings;

  /// 评分信息
  RatingBean rating;

  bool isMakeMoneyLimit;
  int contentLevel;
  bool isFineBook;
  int safeLevel;
  bool allowFree;

  /// 原作者
  String originalAuthor;
  List<dynamic> anchors;
  String authorDesc;

  bool hasCopyright;
  int buyType;
  int sizeType;
  String superscript;
  int currency;
  String contentType;
  bool le;
  bool allowMonthly;
  bool allowVoucher;
  bool allowBeanVoucher;
  bool hasCp;
  int banned;
  int postCount;
  int totalFollower;

  /// 人气
  int latelyFollower;
  int followerCount;

  /// 字数
  String wordCount;

  /// 日更字数
  int serializeWordCount;

  /// 读者留存率
  double retentionRatio;

  /// 最近更新时间
  String updated;

  /// 连载
  bool isSerial;

  /// 总章节数
  int chaptersCount;

  /// 最后章节名
  String lastChapter;
  List<String> gender;

  /// 标签
  List<String> tags;
  bool advertRead;
  String cat;
  bool donate;

  /// 版权
  String copyright;

  /// 版权介绍
  String copyrightDesc;
  bool gg;
  bool isForbidForFreeApp;
  bool isAllowNetSearch;
  bool limit;

  dynamic discount;

  String site;

  String desc;
  int collectorCount;

  String aliases;

  /// 搜索高亮字
  Highlight highlight;

  /// 正在阅读进度
  double progress;

  /// 正在阅读章节连接
  String chapterLink;

  /// 正在阅读章节下标
  int chapterIndex;

  int totalChapter;

  /// 正在阅读章节位置
  double offset;

  /// 书单中的书
  Books book;

  /// 书单中书的评论
  String comment;

  double otherReadRatio;

  Books({
    this.id,
    this.longIntro,
    this.author,
    this.majorCate,
    this.majorCateV2,
    this.minorCate,
    this.minorCateV2,
    this.title,
    this.cover,
    this.creator,
    this.starRatingCount,
    this.starRatings,
    this.rating,
    this.isMakeMoneyLimit,
    this.contentLevel,
    this.isFineBook,
    this.safeLevel,
    this.allowFree,
    this.originalAuthor,
    this.anchors,
    this.authorDesc,
    this.hasCopyright,
    this.buyType,
    this.sizeType,
    this.superscript,
    this.currency,
    this.contentType,
    this.le,
    this.allowMonthly,
    this.allowVoucher,
    this.allowBeanVoucher,
    this.hasCp,
    this.banned,
    this.postCount,
    this.totalFollower,
    this.latelyFollower,
    this.followerCount,
    this.wordCount,
    this.serializeWordCount,
    this.retentionRatio,
    this.updated,
    this.isSerial,
    this.chaptersCount,
    this.lastChapter,
    this.gender,
    this.tags,
    this.advertRead,
    this.cat,
    this.donate,
    this.copyright,
    this.copyrightDesc,
    this.gg,
    this.isForbidForFreeApp,
    this.isAllowNetSearch,
    this.limit,
    this.discount,
    this.shortIntro,
    this.site,
    this.desc,
    this.collectorCount,
    this.aliases,
    this.highlight,
    this.progress,
    this.chapterLink,
    this.chapterIndex,
    this.offset,
    this.book,
    this.comment,
    this.otherReadRatio,
    this.totalChapter,
  });

  static Books fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Books booksBean = Books();
    booksBean.id = map['_id'];
    booksBean.longIntro = map['longIntro'];
    booksBean.majorCateV2 = map['majorCateV2'];
    booksBean.author = map['author'];
    booksBean.minorCateV2 = map['minorCateV2'];
    booksBean.majorCate = map['majorCate'];
    booksBean.minorCate = map['minorCate'];
    booksBean.title = map['title'];
    booksBean.cover = convertImageUrl(map['cover']);
    booksBean.creator = map['creater'];
    booksBean.starRatingCount = map['starRatingCount'];
    booksBean.starRatings = List()
      ..addAll((map['starRatings'] as List ?? [])
          .map((o) => StarRatings.fromMap(o)));
    booksBean.isMakeMoneyLimit = map['isMakeMoneyLimit'];
    booksBean.contentLevel = map['contentLevel'];
    booksBean.isFineBook = map['isFineBook'];
    booksBean.safeLevel = map['safelevel'];
    booksBean.allowFree = map['allowFree'];
    booksBean.originalAuthor = map['originalAuthor'];
    booksBean.anchors = map['anchors'];
    booksBean.authorDesc = map['authorDesc'];
    booksBean.rating = RatingBean.fromMap(map['rating']);
    booksBean.hasCopyright = map['hasCopyright'];
    booksBean.buyType = map['buytype'];
    booksBean.sizeType = map['sizetype'];
    booksBean.superscript = map['superscript'];
    booksBean.currency = map['currency'];
    booksBean.contentType = map['contentType'];
    booksBean.le = map['_le'];
    booksBean.allowMonthly = map['allowMonthly'];
    booksBean.allowVoucher = map['allowVoucher'];
    booksBean.allowBeanVoucher = map['allowBeanVoucher'];
    booksBean.hasCp = map['hasCp'];
    booksBean.banned = map['banned'];
    booksBean.postCount = map['postCount'];
    booksBean.totalFollower = map['totalFollower'];
    booksBean.latelyFollower = map['latelyFollower'];
    booksBean.followerCount = map['followerCount'];
    booksBean.wordCount = getWordCount(map['wordCount'] ?? 0);
    booksBean.serializeWordCount = map['serializeWordCount'];
    booksBean.retentionRatio = dynamicToDouble(map['retentionRatio']);
    booksBean.otherReadRatio = dynamicToDouble(map['otherReadRatio']);
    booksBean.updated = formatDateTime(map['updated']);
    booksBean.isSerial = map['isSerial'];
    booksBean.chaptersCount = map['chaptersCount'];
    booksBean.lastChapter = map['lastChapter'];
    booksBean.gender = List()
      ..addAll((map['gender'] as List ?? []).map((o) => o.toString()));
    booksBean.tags = List()
      ..addAll((map['tags'] as List ?? []).map((o) => o.toString()));
    booksBean.advertRead = map['advertRead'];
    booksBean.cat = map['cat'];
    booksBean.donate = map['donate'];
    booksBean.copyright = map['copyright'];
    booksBean.gg = map['_gg'];
    booksBean.isForbidForFreeApp = map['isForbidForFreeApp'];
    booksBean.isAllowNetSearch = map['isAllowNetSearch'];
    booksBean.limit = map['limit'];
    booksBean.copyrightDesc = map['copyrightDesc'];
    booksBean.discount = map['discount'];
    booksBean.shortIntro = map['shortIntro'];
    booksBean.site = map['site'];
    booksBean.desc = map['desc'];
    booksBean.collectorCount = map['collectorCount'];

    booksBean.aliases = map['aliases'];

    booksBean.highlight = Highlight.fromMap(map['highlight']);

    booksBean.book = Books.fromJson(map['book']);
    booksBean.comment = map['comment'];
    return booksBean;
  }
}

/// title : ["斗","破","苍","穹"]
class Highlight {
  List<String> title;

  static Highlight fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Highlight highlightBean = Highlight();
    highlightBean.title = List()
      ..addAll((map['title'] as List ?? []).map((o) => o.toString()));
    return highlightBean;
  }

  Map toJson() => {
    "title": title,
  };
}

class RatingBean {
  int count;
  double score;
  String tip;
  bool isEffect;

  static RatingBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RatingBean ratingBean = RatingBean();
    ratingBean.count = map['count'];
    ratingBean.score = dynamicToDouble(map['score']);
    ratingBean.tip = map['tip'];
    ratingBean.isEffect = map['isEffect'];
    return ratingBean;
  }

  Map toJson() => {
    "count": count,
    "score": score,
    "tip": tip,
    "isEffect": isEffect,
  };
}

/// count : 214
/// star : 0
class StarRatings {
  int count;
  int star;

  static StarRatings fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    StarRatings starRatingsBean = StarRatings();
    starRatingsBean.count = map['count'];
    starRatingsBean.star = map['star'];
    return starRatingsBean;
  }

  Map toJson() => {
    "count": count,
    "star": star,
  };
}

class StatisticsResult {
  List<Statistics> male;
  List<Statistics> female;
  List<Statistics> picture;
  List<Statistics> press;
  bool ok;

  static StatisticsResult fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    StatisticsResult bBean = StatisticsResult();
    bBean.male = List()
      ..addAll((map['male'] as List ?? []).map((o) => Statistics.fromMap(o)));
    bBean.female = List()
      ..addAll((map['female'] as List ?? []).map((o) => Statistics.fromMap(o)));
    bBean.picture = List()
      ..addAll(
          (map['picture'] as List ?? []).map((o) => Statistics.fromMap(o)));
    bBean.press = List()
      ..addAll((map['press'] as List ?? []).map((o) => Statistics.fromMap(o)));
    bBean.ok = map['ok'];
    return bBean;
  }

  Map toJson() => {
    "male": male,
    "female": female,
    "picture": picture,
    "press": press,
    "ok": ok,
  };
}

class Statistics {
  String name;
  int bookCount;
  int monthlyCount;
  String icon;
  List<String> bookCover;

  static Statistics fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Statistics statistics = Statistics();
    statistics.name = map['name'];
    statistics.bookCount = map['bookCount'];
    statistics.monthlyCount = map['monthlyCount'];
    statistics.icon = "${READER_IMAGE_URL}${map['icon']}";
    statistics.bookCover = List()
      ..addAll((map['bookCover'] as List ?? []).map((o) => o.toString()));
    return statistics;
  }

  Map toJson() => {
    "name": name,
    "bookCount": bookCount,
    "monthlyCount": monthlyCount,
    "icon": icon,
    "bookCover": bookCover,
  };
}

class CategoryResult {
  List<BookCategory> male;
  List<BookCategory> female;
  List<BookCategory> picture;
  List<BookCategory> press;
  bool ok;

  static CategoryResult fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CategoryResult result = CategoryResult();
    result.male = List()
      ..addAll((map['male'] as List ?? []).map((o) => BookCategory.fromMap(o)));
    result.female = List()
      ..addAll(
          (map['female'] as List ?? []).map((o) => BookCategory.fromMap(o)));
    result.picture = List()
      ..addAll(
          (map['picture'] as List ?? []).map((o) => BookCategory.fromMap(o)));
    result.press = List()
      ..addAll(
          (map['press'] as List ?? []).map((o) => BookCategory.fromMap(o)));
    result.ok = map['ok'];
    return result;
  }

  Map toJson() => {
    "male": male,
    "female": female,
    "picture": picture,
    "press": press,
    "ok": ok,
  };
}

class BookCategory {
  String major;
  List<String> mins;

  static BookCategory fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookCategory category = BookCategory();
    category.major = map['major'];
    category.mins = List()
      ..addAll((map['mins'] as List ?? []).map((o) => o.toString()));
    return category;
  }

  Map toJson() => {
    "major": major,
    "mins": mins,
  };
}

class RankingResult {
  List<Ranking> male;
  List<Ranking> female;
  List<Ranking> picture;
  List<Ranking> epub;
  bool ok;

  Ranking ranking;

  static RankingResult fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RankingResult bBean = RankingResult();
    bBean.male = List()
      ..addAll((map['male'] as List ?? []).map((o) => Ranking.fromMap(o)));
    bBean.female = List()
      ..addAll((map['female'] as List ?? []).map((o) => Ranking.fromMap(o)));
    bBean.picture = List()
      ..addAll((map['picture'] as List ?? []).map((o) => Ranking.fromMap(o)));
    bBean.epub = List()
      ..addAll((map['epub'] as List ?? []).map((o) => Ranking.fromMap(o)));
    bBean.ok = map['ok'];
    bBean.ranking = Ranking.fromMap(map['ranking']);
    return bBean;
  }

  Map toJson() => {
    "male": male,
    "female": female,
    "picture": picture,
    "epub": epub,
    "ok": ok,
    "ranking": ranking,
  };
}

class Ranking {
  String updated;
  String title;
  String tag;
  String cover;
  String icon;
  int v;
  String monthRank;
  String totalRank;
  String shortTitle;
  String created;
  String biTag;
  bool isSub;
  bool collapse;
  bool bNew;
  String gender;
  int priority;
  List<Books> books;
  String id;
  int total;

  static Ranking fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Ranking rankingBean = Ranking();
    rankingBean.updated = map['updated'];
    rankingBean.title = map['title'];
    rankingBean.tag = map['tag'];
    rankingBean.cover = '${READER_IMAGE_URL}${map['cover']}';
    rankingBean.icon = map['icon'];
    rankingBean.v = map['__v'];
    rankingBean.monthRank = map['monthRank'];
    rankingBean.totalRank = map['totalRank'];
    rankingBean.shortTitle = map['shortTitle'];
    rankingBean.created = map['created'];
    rankingBean.biTag = map['biTag'];
    rankingBean.isSub = map['isSub'];
    rankingBean.collapse = map['collapse'];
    rankingBean.bNew = map['new'];
    rankingBean.gender = map['gender'];
    rankingBean.priority = map['priority'];
    rankingBean.books = List()
      ..addAll((map['books'] as List ?? []).map((o) => Books.fromJson(o)));
    rankingBean.id = map['_id'];
    rankingBean.total = map['total'];
    return rankingBean;
  }

  Map toJson() => {
    "updated": updated,
    "title": title,
    "tag": tag,
    "cover": cover,
    "icon": icon,
    "__v": v,
    "monthRank": monthRank,
    "totalRank": totalRank,
    "shortTitle": shortTitle,
    "created": created,
    "biTag": biTag,
    "isSub": isSub,
    "collapse": collapse,
    "new": bNew,
    "gender": gender,
    "priority": priority,
    "books": books,
    "_id": id,
    "total": total,
  };
}

class DocsBean {
  String id;
  int rating;
  String type;
  BookAuthorBean author;
  Books book;
  int likeCount;
  double priority;
  String block;
  String state;
  String updated;
  String created;
  String content;

  String ratingDesc;

  static DocsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DocsBean docsBean = DocsBean();
    docsBean.id = map['_id'];
    docsBean.rating = map['rating'];
    docsBean.type = map['type'];
    docsBean.author = BookAuthorBean.fromMap(map['author']);
    docsBean.book = Books.fromJson(map['book']);
    docsBean.likeCount = map['likeCount'];
    docsBean.priority = dynamicToDouble(map['priority']);
    docsBean.block = map['block'];
    docsBean.state = map['state'];
    docsBean.created = formatDateTime(map['created']);
    docsBean.updated = formatDateTime(map['updated']);
    docsBean.content = map['content'];

    docsBean.ratingDesc = getRatingDesc(map['rating']);
    return docsBean;
  }

  Map toJson() => {
    "_id": id,
    "rating": rating,
    "type": type,
    "author": author,
    "book": book,
    "likeCount": likeCount,
    "priority": priority,
    "block": block,
    "state": state,
    "updated": updated,
    "created": created,
    "content": content,
  };
}

class Post {
  String id;
  Books book;
  BookAuthorBean author;
  String type;
  int likeCount;
  String block;
  bool haveImage;
  String state;
  String updated;
  String created;
  int commentCount;
  int voteCount;
  String content;
  String title;

  static Post fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Post post = Post();
    post.id = map['_id'];
    post.book = Books.fromJson(map['book']);
    post.author = BookAuthorBean.fromMap(map['author']);
    post.type = map['type'];
    post.likeCount = map['likeCount'];
    post.block = map['block'];
    post.haveImage = map['haveImage'];
    post.state = map['state'];
    post.updated = map['updated'];
    post.created = map['created'];
    post.commentCount = map['commentCount'];
    post.voteCount = map['voteCount'];
    post.content = map['content'];
    post.title = map['title'];
    return post;
  }

  Map toJson() => {
    "_id": id,
    "book": book,
    "author": author,
    "type": type,
    "likeCount": likeCount,
    "block": block,
    "haveImage": haveImage,
    "state": state,
    "updated": updated,
    "created": created,
    "commentCount": commentCount,
    "voteCount": voteCount,
    "content": content,
    "title": title,
  };
}

class BookReviews {
  String id;
  int rating;
  BookAuthorBean author;
  HelpfulBean helpful;
  int likeCount;
  String state;
  String updated;
  String created;
  int commentCount;
  String content;
  String title;
  String ratingDesc;

  static BookReviews fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookReviews reviewsBean = BookReviews();
    reviewsBean.id = map['_id'];
    reviewsBean.rating = map['rating'];
    reviewsBean.author = BookAuthorBean.fromMap(map['author']);
    reviewsBean.helpful = HelpfulBean.fromMap(map['helpful']);
    reviewsBean.likeCount = map['likeCount'];
    reviewsBean.state = map['state'];
    reviewsBean.created = formatDateTime(map['created']);
    reviewsBean.updated = formatDateTime(map['updated']);
    reviewsBean.commentCount = map['commentCount'];
    reviewsBean.content = map['content'];
    reviewsBean.title = map['title'];
    reviewsBean.ratingDesc = getRatingDesc(map['rating']);
    return reviewsBean;
  }

  Map toJson() => {
    "_id": id,
    "rating": rating,
    "author": author,
    "helpful": helpful,
    "likeCount": likeCount,
    "state": state,
    "updated": updated,
    "created": created,
    "commentCount": commentCount,
    "content": content,
    "title": title,
  };
}

class HelpfulBean {
  int total;
  int yes;
  int no;

  static HelpfulBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    HelpfulBean helpfulBean = HelpfulBean();
    helpfulBean.total = map['total'];
    helpfulBean.yes = map['yes'];
    helpfulBean.no = map['no'];
    return helpfulBean;
  }

  Map toJson() => {
    "total": total,
    "yes": yes,
    "no": no,
  };
}

class BookAuthorBean {
  String id;
  String avatar;
  String nickname;
  String activityAvatar;
  String type;
  int lv;
  String gender;

  static BookAuthorBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookAuthorBean authorBean = BookAuthorBean();
    authorBean.id = map['_id'];
    authorBean.avatar = '${READER_IMAGE_URL}${map['avatar']}';
    authorBean.nickname = map['nickname'];
    authorBean.activityAvatar = map['activityAvatar'];
    authorBean.type = map['type'];
    authorBean.lv = map['lv'];
    authorBean.gender = map['gender'];
    return authorBean;
  }

  Map toJson() => {
    "_id": id,
    "avatar": avatar,
    "nickname": nickname,
    "activityAvatar": activityAvatar,
    "type": type,
    "lv": lv,
    "gender": gender,
  };
}

class ChapterResult {
  String id;
  String name;
  String source;
  String book;
  String link;
  List<Chapters> chapters;
  String updated;
  String host;

  static ChapterResult fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ChapterResult bean = ChapterResult();
    bean.id = map['_id'];
    bean.name = map['name'];
    bean.source = map['source'];
    bean.book = map['book'];
    bean.link = map['link'];
    bean.chapters = List()
      ..addAll((map['chapters'] as List ?? []).map((o) => Chapters.fromMap(o)));
    bean.updated = map['updated'];
    bean.host = map['host'];
    return bean;
  }

  Map toJson() => {
    "_id": id,
    "name": name,
    "source": source,
    "book": book,
    "link": link,
    "chapters": chapters,
    "updated": updated,
    "host": host,
  };
}

class Chapters {
  String title;
  String link;
  String id;
  int time;
  String chapterCover;
  int totalPage;
  int partSize;
  int order;
  int currency;
  bool unReadable;
  bool isVip;

  static Chapters fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Chapters chaptersBean = Chapters();
    chaptersBean.title = map['title'];
    chaptersBean.link = "${READER_CHAPTER_URL}${map['link']}";
    chaptersBean.id = map['id'];
    chaptersBean.time = map['time'];
    chaptersBean.chapterCover = map['chapterCover'];
    chaptersBean.totalPage = map['totalpage'];
    chaptersBean.partSize = map['partsize'];
    chaptersBean.order = map['order'];
    chaptersBean.currency = map['currency'];
    chaptersBean.unReadable = map['unreadble'];
    chaptersBean.isVip = map['isVip'];
    return chaptersBean;
  }

  Map toJson() => {
    "title": title,
    "link": link,
    "id": id,
    "time": time,
    "chapterCover": chapterCover,
    "totalpage": totalPage,
    "partsize": partSize,
    "order": order,
    "currency": currency,
    "unreadble": unReadable,
    "isVip": isVip,
  };
}

class BtocResult {
  String id;
  bool isCharge;
  String name;
  String lastChapter;
  String updated;
  String source;
  String link;
  bool starting;
  int chaptersCount;
  String host;

  static BtocResult fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BtocResult bBean = BtocResult();
    bBean.id = map['_id'];
    bBean.isCharge = map['isCharge'];
    bBean.name = map['name'];
    bBean.lastChapter = map['lastChapter'];
    bBean.updated = map['updated'];
    bBean.source = map['source'];
    bBean.link = map['link'];
    bBean.starting = map['starting'];
    bBean.chaptersCount = map['chaptersCount'];
    bBean.host = map['host'];
    return bBean;
  }

  Map toJson() => {
    "_id": id,
    "isCharge": isCharge,
    "name": name,
    "lastChapter": lastChapter,
    "updated": updated,
    "source": source,
    "link": link,
    "starting": starting,
    "chaptersCount": chaptersCount,
    "host": host,
  };
}

/// title : "第一章 惊蛰"
/// body : "\n\r\n\r\n\r请安装最新版追书 以便使用优质资源"
/// isVip : false
/// order : 1
/// currency : 15
/// id : "595ce4a9c9f6f6b3439bfb30"
/// created : "2017-07-05T13:07:53.680Z"
/// updated : "2019-04-12T01:56:41.195Z"
/// cpContent : "二月二，龙抬头。"
class ChapterInfo {
  String title;
  String body;
  bool isVip;
  int order;
  int currency;
  String id;
  String created;
  String updated;
  String cpContent;

  List<Map<String, int>> pageOffsets;

  static ChapterInfo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ChapterInfo chapterBean = ChapterInfo();
    chapterBean.title = map['title'];
    chapterBean.body = map['body'];
    chapterBean.isVip = map['isVip'];
    chapterBean.order = map['order'];
    chapterBean.currency = map['currency'];
    chapterBean.id = map['id'];
    chapterBean.created = formatDateTime(map['created']);
    chapterBean.updated = formatDateTime(map['updated']);
    chapterBean.cpContent = map['cpContent']
        .toString()
        .replaceAll('\n\r\n\r\n\r', '\n\r')
        .replaceAll('\r\n\n　　\r\n\n', '\n\r')
        .replaceAll('\r\n\r\n　　\r\n\r\n　　\r\n\r\n', '\n\r')
        .replaceAll('\r\n\r\n　　\r\n\r\n', '\n\r');
    chapterBean.pageOffsets = ReaderPageAgent.getPageOffsets(
        map['cpContent']
            .toString()
            .replaceAll('\n\r\n\r\n\r', '\n\r')
            .replaceAll('\r\n\n　　\r\n\n', '\n\r')
            .replaceAll('\r\n\r\n　　\r\n\r\n　　\r\n\r\n', '\n\r')
            .replaceAll('\r\n\r\n　　\r\n\r\n', '\n\r'),
        Utils.height - Utils.topSafeHeight - 36.0,
        Utils.width - 18.0,
        18.0);
    return chapterBean;
  }

  Map toJson() => {
    "title": title,
    "body": body,
    "isVip": isVip,
    "order": order,
    "currency": currency,
    "id": id,
    "created": created,
    "updated": updated,
    "cpContent": cpContent,
  };
}

class BookList {
  String bookListId;
  String id;
  BookAuthorBean author;
  String authorStr;
  String title;
  String desc;
  String gender;
  int updateCount;
  String created;
  String updated;
  List<String> tags;
  String stickStopTime;
  bool isDraft;
  dynamic isDistillate;
  int collectorCount;
  String shareLink;
  int total;
  List<Books> books;

  int bookCount;
  String cover;
  List<String> covers;

  static BookList fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookList bookListBean = BookList();
    bookListBean.bookListId = map['id'];
    bookListBean.id = map['_id'];
    bookListBean.authorStr = map['author'] is String ? map['author'] : "";
    bookListBean.author =
    map['author'] is String ? null : BookAuthorBean.fromMap(map['author']);
    bookListBean.title = map['title'];
    bookListBean.desc = map['desc'];
    bookListBean.gender = map['gender'];
    bookListBean.updateCount = map['updateCount'];
    bookListBean.created = formatDateTime(map['created']);
    bookListBean.updated = formatDateTime(map['updated']);
    bookListBean.tags = List()
      ..addAll((map['tags'] as List ?? []).map((o) => o.toString()))
      ..remove("COLLECT_COUNT_X000+")
      ..remove("AUTHENTIC_LISTOWNER")
      ..remove("MIND_BOOKSTORE")
      ..remove("EDITOR_RECOMMEND");
    bookListBean.stickStopTime = map['stickStopTime'];
    bookListBean.isDraft = map['isDraft'];
    bookListBean.isDistillate = map['isDistillate'];
    bookListBean.collectorCount = map['collectorCount'];
    bookListBean.shareLink = map['shareLink'];
    bookListBean.total = map['total'];
    bookListBean.books = List()
      ..addAll((map['books'] as List ?? []).map((o) => Books.fromJson(o)));
    bookListBean.bookCount = map['bookCount'];
    bookListBean.cover = convertImageUrl(map['cover']);
    bookListBean.covers = List()
      ..addAll((map['covers'] as List ?? [])
          .map((o) => convertImageUrl(o.toString())));
    return bookListBean;
  }

  Map toJson() => {
    "id": bookListId,
    "_id": id,
    "author": author,
    "title": title,
    "desc": desc,
    "gender": gender,
    "updateCount": updateCount,
    "created": created,
    "updated": updated,
    "tags": tags,
    "stickStopTime": stickStopTime,
    "isDraft": isDraft,
    "isDistillate": isDistillate,
    "collectorCount": collectorCount,
    "shareLink": shareLink,
    "total": total,
    "books": books,
    "bookCount": bookCount,
    "cover": cover,
    "covers": covers,
    "authorStr": authorStr,
  };
}

/// word : "全职高手"
/// times : 130
/// isNew : 0
/// soaring : 2
class SearchHotWords {
  String word;
  int times;
  int isNew;
  int soaring;
  String book;

  static SearchHotWords fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SearchHotWords hotWords = SearchHotWords();
    hotWords.word = map['word'];
    hotWords.times = map['times'];
    hotWords.isNew = map['isNew'];
    hotWords.soaring = map['soaring'];
    hotWords.book = map['book'];
    return hotWords;
  }

  Map toJson() => {
    "word": word,
    "times": times,
    "isNew": isNew,
    "soaring": soaring,
    "book": book,
  };
}

/// name : "情感"
/// tags : ["纯爱","热血","言情","现言","古言","情有独钟","搞笑","青春","欢喜冤家","爽文","虐文"]
class Tag {
  String name;
  List<String> tags;

  static Tag fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Tag tag = Tag();
    tag.name = map['name'];
    tag.tags = List()
      ..addAll((map['tags'] as List ?? []).map((o) => o.toString()));
    return tag;
  }

  Map toJson() => {
    "name": name,
    "tags": tags,
  };
}

String convertImageUrl(String imageUrl) {
  if (imageUrl == null || imageUrl == '') return '';
  return imageUrl.replaceAll("%2F", "/").replaceAll("%3A", ":").substring(7);
}

String getWordCount(int wordCount) {
  if (wordCount > 10000) {
    return (wordCount / 10000).toStringAsFixed(1) + "万字";
  }
  return wordCount.toString() + "字";
}

String getRatingDesc(int rating) {
  switch (rating) {
    case 1:
      return '浪费生命';
    case 2:
      return '打发时间';
    case 3:
      return '值得一看';
    case 4:
      return '非常喜欢';
    case 5:
      return '必看之作';
    default:
      return '慢性自杀';
  }
}

String formatDateTime(String datetime) {
  return datetime == null ? "" : DateTimeHelper.datetimeFormat(DateTime.parse(datetime).millisecond, 'yyyyMMdd');
}

double dynamicToDouble(dynamic variable) {
  return (variable is String)
      ? double.parse(variable)
      : (variable is int) ? variable.toDouble() : variable;
}

class ReaderPageAgent {
  static List<Map<String, int>> getPageOffsets(
      String content, double height, double width, double fontSize) {
    String tempStr = content;
    List<Map<String, int>> pageConfig = [];
    int last = 0;
    while (true) {
      Map<String, int> offset = {};
      offset['start'] = last;
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text =
          TextSpan(text: tempStr, style: TextStyle(fontSize: fontSize));
      textPainter.layout(maxWidth: width);
      var end = textPainter.getPositionForOffset(Offset(width, height)).offset;

      if (end == 0) {
        break;
      }
      tempStr = tempStr.substring(end, tempStr.length);
      offset['end'] = last + end;
      last = last + end;
      pageConfig.add(offset);
    }
    return pageConfig;
  }
}