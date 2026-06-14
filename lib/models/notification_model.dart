import 'base.dart';

class NotificationModel extends Model {
  late final String? icon;
  late final String createdAt;
  String? readAt;
  late final bool isReaded;
  late final String createdTime;
  late final String type;
  late final String title;
  late final String body;
  late final String? notifyId;
  String? senderId;

  NotificationModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    icon = stringNullFromJson(json, "icon");
    createdAt = stringFromJson(json, "created_at");
    readAt = stringNullFromJson(json, "read_at");
    isReaded = boolFromJson(json, "is_readed");
    createdTime = stringFromJson(json, "created_time");
    type = stringFromJson(json, "type");
    title = stringFromJson(json, "title");
    body = stringFromJson(json, "body");
    notifyId = stringNullFromJson(json, "notify_id");
    senderId = stringNullFromJson(json, "sender_id");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "created_at": createdAt,
    "read_at": readAt,
    "is_readed": isReaded,
    "created_time": createdTime,
    "type": type,
    "title": title,
    "body": body,
    "notify_id": notifyId,
    "sender_id": senderId,
  };
}
