import 'package:dio/dio.dart';

Dio initializeDio() {
  final dio = Dio();

  // Common configurations for Dio
  dio.options.baseUrl = "https://example.com"; // Replace with your base URL
  dio.options.connectTimeout = Duration(seconds: 5000); // 5 seconds
  dio.options.receiveTimeout = Duration(seconds: 5000); // 5 seconds

  // Add headers or interceptors if needed
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // Example: Add headers dynamically
        options.headers['Content-Type'] = 'application/json';
        // Example: Add token to headers if available
        // options.headers['Authorization'] = "Bearer <token>";
        return handler.next(options); // Continue
      },
      onError: (error, handler) {
        // Log or handle errors globally
        print("Dio Error: ${error.message}");
        return handler.next(error); // Continue
      },
    ),
  );

  return dio;
}