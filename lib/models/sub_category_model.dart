import 'base.dart';

class SubCategoryModel extends Model {
  late final String name;

  SubCategoryModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    name = stringFromJson(json, "name");
  }

  @override
  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
