import 'base.dart';

class CategoryModel extends Model {
  late final String name;
  late final String image;

  CategoryModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    name = stringFromJson(json, "name");
    
    if (json?['media'] != null && json?['media'] is String) {
      image = json!['media'];
    } else if (json?['image'] != null && json?['image'] is String) {
      image = json!['image'];
    } else {
      image = stringFromJson(json?['image'], "path");
    }
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": {"path": image},
  };
}
