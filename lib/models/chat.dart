// // To parse this JSON data, do
// //
// //     final chatModel = chatModelFromJson(jsonString);





// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class ChatModel {
//   Driver driver;
//   Messages messages;

//   ChatModel({
//     required this.driver,
//     required this.messages,
//   });

//   factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
//     driver: Driver.fromJson(json["driver"]),
//     messages: Messages.fromJson(json["messages"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "driver": driver.toJson(),
//    };
// }

// class Driver {
//   int id;
//   String name;
//   String phoneCode;
//   String phone;
//   Avatar avatar;
//   String userType;

//   Driver({
//     required this.id,
//     required this.name,
//     required this.phoneCode,
//     required this.phone,
//     required this.avatar,
//     required this.userType,
//   });

//   factory Driver.fromJson(Map<String, dynamic> json) => Driver(
//     id: json["id"],
//     name: json["name"],
//     phoneCode: json["phone_code"],
//     phone: json["phone"],
//     avatar: Avatar.fromJson(json["avatar"]),
//     userType: json["user_type"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "phone_code": phoneCode,
//     "phone": phone,
//     "avatar": avatar.toJson(),
//     "user_type": userType,
//   };
// }

// class Avatar {
//   String id;
//   String path;
//   String type;
//   String option;

//   Avatar({
//     required this.id,
//     required this.path,
//     required this.type,
//     required this.option,
//   });

//   factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
//     id: json["id"],
//     path: json["path"],
//     type: json["type"],
//     option: json["option"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "path": path,
//     "type": type,
//     "option": option,
//   };
// }

// class Messages {
//   List<Message> data;
//   Links links;
//   Meta meta;

//   Messages({
//     required this.data,
//     required this.links,
//     required this.meta,
//   });

//   factory Messages.fromJson(Map<String, dynamic> json) => Messages(
//     data: List<Message>.from(json["data"].map((x) => Message.fromJson(x))),
//     links: Links.fromJson(json["links"]),
//     meta: Meta.fromJson(json["meta"]),
//   );


// }



// class Links {
//   String first;
//   String last;
//   dynamic prev;
//   dynamic next;

//   Links({
//     required this.first,
//     required this.last,
//     required this.prev,
//     required this.next,
//   });

//   factory Links.fromJson(Map<String, dynamic> json) => Links(
//     first: json["first"],
//     last: json["last"],
//     prev: json["prev"],
//     next: json["next"],
//   );

//   Map<String, dynamic> toJson() => {
//     "first": first,
//     "last": last,
//     "prev": prev,
//     "next": next,
//   };
// }

// class Meta {
//   int currentPage;
//   int from;
//   int lastPage;
//   List<Link> links;
//   String path;
//   int perPage;
//   int to;
//   int total;

//   Meta({
//     required this.currentPage,
//     required this.from,
//     required this.lastPage,
//     required this.links,
//     required this.path,
//     required this.perPage,
//     required this.to,
//     required this.total,
//   });

//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//     currentPage: json["current_page"],
//     from: json["from"],
//     lastPage: json["last_page"],
//     links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
//     path: json["path"],
//     perPage: json["per_page"],
//     to: json["to"],
//     total: json["total"],
//   );

//   Map<String, dynamic> toJson() => {
//     "current_page": currentPage,
//     "from": from,
//     "last_page": lastPage,
//     "links": List<dynamic>.from(links.map((x) => x.toJson())),
//     "path": path,
//     "per_page": perPage,
//     "to": to,
//     "total": total,
//   };
// }

// class Link {
//   String? url;
//   String label;
//   int? page;
//   bool active;

//   Link({
//     required this.url,
//     required this.label,
//     required this.page,
//     required this.active,
//   });

//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//     url: json["url"],
//     label: json["label"],
//     page: json["page"],
//     active: json["active"],
//   );

//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "label": label,
//     "page": page,
//     "active": active,
//   };
// }
