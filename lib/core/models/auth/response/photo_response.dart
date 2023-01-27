import 'package:egov/core/api/core.dart';

class PhotoResponse extends ApiResponse {
  final bool success;
  final String message;
  final String imageUrl;

  PhotoResponse(
      {required this.success, required this.message, required this.imageUrl});

  factory PhotoResponse.fromJson(Map<String, dynamic> json) {
    return PhotoResponse(
      success: json['success'],
      message: json['message'],
      imageUrl: json['data']['url'],
    );
  }
  @override
  String toString() {
    return 'success:$success, message: $message, url: $imageUrl';
  }
}
