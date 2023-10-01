import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService3<T> {
  final String baseUrl = "http://192.168.133.43:3000";

  Future<Map<String, dynamic>> createRecord(String tableName, T data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create/$tableName'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }

  Future<List<Map<String, dynamic>>> readRecords(String tableName) async {
    final response = await http.get(Uri.parse('$baseUrl/read/$tableName'));
    final List<dynamic> recordsJson = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(recordsJson);
  }

  Future<Map<String, dynamic>> updateRecord(String tableName, T data, String condition) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/$tableName'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'data': data, 'condition': condition}),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> deleteRecord(String tableName, String condition) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete/$tableName'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'condition': condition}),
    );

    return jsonDecode(response.body);
  }

  T dataFromJson(Map<String, dynamic> json) {
    //
    throw UnimplementedError();
  }

  Map<String, dynamic> dataToJson(T data) {
    //
    throw UnimplementedError();
  }

}
