import 'base.dart';

class CategoryModel extends Model {
  late final String name;
  late final String image;

  CategoryModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    name = stringFromJson(json, "name");
    image = stringFromJson(json?['image'], "path");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": {"path": image},
  };
}
