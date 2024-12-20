import 'package:dio/dio.dart';

class LoginRepository {
  final Dio _dio;

  LoginRepository(this._dio);

  Future<bool> login(String username, String password) async {
    try {
      // API endpoint for login
      const String loginUrl = 'https://json-placeholder.mock.beeceptor.com/login/';

      // API request payload
      final response = await _dio.post(
        loginUrl,
        data: {
          "username": username,
          "password": password,
        },
      );

      // Check if login was successful
      if (response.statusCode == 200 && response.data['success'] == true) {
        // Save token or session info if required
        // Example: response.data['token']
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        throw Exception("Login failed: ${e.response?.data['message']}");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}