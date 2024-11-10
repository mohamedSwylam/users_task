import 'package:dio/dio.dart';

class ApiService {
  
  final Dio _dio;

  ApiService(this._dio);

  Future<List<dynamic>> fetchUsers(int page) async {
    try {
      final response = await _dio.get('https://reqres.in/api/users', queryParameters: {'page': page});
      return response.data['data'];
    } catch (error) {
      throw Exception('Failed to load users');
    }
  }

  Future<Map<String, dynamic>> fetchUserDetails(int userId) async {
    try {
      final response = await _dio.get('https://reqres.in/api/users/$userId');
      return response.data['data'];
    } catch (error) {
      throw Exception('Failed to load user details');
    }
  }
}