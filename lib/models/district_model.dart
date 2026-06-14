import 'base.dart';

/// Represents a city option returned by the API.
class DistrictModel extends Model {
  late final String name;

  DistrictModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    name = stringFromJson(json, "name");
  }

  @override
  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
