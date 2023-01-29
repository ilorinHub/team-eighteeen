import 'package:egov/core/api/core.dart';

class GooglePlacePredictions extends ApiResponse {
  String? secondarytext;
  String? maintext;
  String? placeID;
  String? description;

  GooglePlacePredictions({
    this.maintext,
    this.placeID,
    this.secondarytext,
    this.description,
  });

  GooglePlacePredictions.fromJson(Map<String, dynamic> json) {
    placeID = json['place_id'];
    maintext = json['structured_formatting']['main_text'];
    secondarytext = json['structured_formatting']['secondary_text'];
    description = json['description'];
  }
}
