import 'package:egov/core/api/utils/utils.dart';

final baseUrl = AppConfig.baseUrl;
final apiVersion = AppConfig.apiVersion;

final userServiceUrl = '${baseUrl}user_service$apiVersion';

// auth endpoints
class _AuthEndpoints {
  final login = '$baseUrl/$apiVersion/auth/login';
  final signup = '$baseUrl/$apiVersion/auth/signup';
}

// endpoints
final authEndpoints = _AuthEndpoints();
