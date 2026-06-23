import 'package:thimar/models/base.dart';

class ReviewModel extends Model {
  late double value;
  late String comment;
  late String clientName;
  late String clientImage;

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = stringFromJson(json, "id");
    value = doubleFromJson(json, "value");
    comment = stringFromJson(json, "comment");
    clientName = stringFromJson(json, "client_name");
    clientImage = stringFromJson(json, "client_image");
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "comment": comment,
        "client_name": clientName,
        "client_image": clientImage,
      };
}
