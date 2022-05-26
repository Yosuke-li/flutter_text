//模型
class NotificationModel {
  String? type;
  String? title;
  String? msg;
  int? id;

  NotificationModel({this.id, this.title, this.type, this.msg});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final NotificationModel result = NotificationModel();
    if (json == null) return result;
    result.type = json['type'];
    result.title = json['title'];
    result.msg = json['msg'];
    result.id = json['id'];
    return result;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (type != null) {
      result['type'] = type;
    }
    if (title != null) {
      result['title'] = title;
    }
    if (msg != null) {
      result['msg'] = msg;
    }
    if (id != null) {
      result['id'] = id;
    }
    return result;
  }

  @override
  String toString() {
    return 'NotificationModel[id=$id, title=$title, msg=$msg, type=$type]';
  }
}

enum NotificationType {
  Message,
  SelfChat,
}

extension NotificationTypeTxt on NotificationType {
  String get enumToString {
    switch (this) {
      case NotificationType.Message:
        return 'message';
        break;
      case NotificationType.SelfChat:
        return 'selfChat';
        break;
    }
  }
}