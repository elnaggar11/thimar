import 'base.dart';

class MessageModel extends Model {
  late final String contextType;
  String? contextId;
  late final String message;
  late final bool isRead;
  late final DateTime createdAt;
  late final DateTime updatedAt;
  late final String createdAtHuman;
  late final UserMini sender;
  late final UserMini receiver;

  MessageModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, 'id');
    contextType = stringFromJson(json, 'context_type');
    contextId = stringNullFromJson(json, 'context_id');
    message = stringFromJson(json, 'message');
    isRead = boolFromJson(json, 'is_read');
    createdAt = dateFromJson(json, 'created_at');
    updatedAt = dateFromJson(json, 'updated_at');
    createdAtHuman = stringFromJson(json, 'created_at_human');
    sender = UserMini.fromJson(json?['sender'] as Map<String, dynamic>?);
    receiver = UserMini.fromJson(json?['receiver'] as Map<String, dynamic>?);
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'context_type': contextType,
    'context_id': contextId,
    'message': message,
    'is_read': isRead,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'created_at_human': createdAtHuman,
    'sender': sender.toJson(),
    'receiver': receiver.toJson(),
  };
}

class UserMini extends Model {
  late final String name;
  late final String userType;
  String? avatarPath;

  UserMini.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, 'id');
    name = stringFromJson(json, 'name');
    userType = stringFromJson(json, 'user_type');
    if (json?['avatar'] is Map) {
      avatarPath = stringFromJson(json?['avatar'], 'path');
    } else {
      avatarPath = stringNullFromJson(json, 'avatar');
    }
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'user_type': userType,
    'avatar': avatarPath,
  };
}
