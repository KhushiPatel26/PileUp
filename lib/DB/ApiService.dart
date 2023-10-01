import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl="http://192.168.133.43:3000";

  Future<Map<String, dynamic>> createRecord(String tableName, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'tableName': tableName, 'data': data}),
    );

    return jsonDecode(response.body);
  }

  Future<List<dynamic>> readRecords(String tableName) async {
    final response = await http.get(Uri.parse('$baseUrl/read/$tableName'));
    return jsonDecode(response.body)['records'];
  }

  Future<Map<String, dynamic>> updateRecord(String tableName, int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/$tableName/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'data': data}),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> deleteRecord(String tableName, int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$tableName/$id'));
    return jsonDecode(response.body);
  }
}
