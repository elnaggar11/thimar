import 'base.dart';

class SliderModel extends Model {
  late final String image;
  late final String title, description;

  SliderModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    image = stringFromJson(json?['image'], "path");
    title = stringFromJson(json, "title");
    description = stringFromJson(json, "description");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "image": {"path": image},
    "title": title,
    "description": description,
  };
}
