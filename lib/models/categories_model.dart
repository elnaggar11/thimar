import 'package:thimar/models/base.dart';

class CategoriesModel extends Model {
  late String name;
  late String image;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    final imageValue = json["image"];

    id = stringFromJson(json, "id");
    name = stringFromJson(json, "name");
    image = imageValue is Map<String, dynamic>
        ? stringFromJson(imageValue, "path")
        : (imageValue?.toString() ?? '');
  }

  @override
  Map<String, dynamic> toJson() => {"id": id, "name": name, "image": image};
}
