import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService2<T> {
  final String baseUrl = "http://192.168.133.43:3000";

  Future<Map<String, dynamic>> createRecord(String tableName, T data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'tableName': tableName, 'data': data}),// data.toJson()
    );

    return jsonDecode(response.body);
  }

  Future<List<T>> readRecords(String tableName) async {
    final response = await http.get(Uri.parse('$baseUrl/read/$tableName'));
    final List<dynamic> recordsJson = jsonDecode(response.body)['records'];
    print("recordsJson  "+recordsJson.toString());
    return recordsJson.map<T>((json) => dataFromJson(json)).toList();
  }

  // Future<Map<String, dynamic>> updateRecord(String tableName, int id, T data) async {
  //   final response = await http.put(
  //     Uri.parse('$baseUrl/update/$tableName/$id'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'data': data}),//data.toJson()
  //   );
  //
  //   return jsonDecode(response.body);
  // }
  Future<Map<String, dynamic>> updateRecord(String tableName, String id ,String condition, T data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/$tableName/$id/$condition'), // Use the condition in the URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'data': data}),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> deleteRecord(String tableName, int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$tableName/$id'));
    return jsonDecode(response.body);
  }

  T dataFromJson(Map<String, dynamic> json) {

    throw UnimplementedError();
  }
}
//
// class ApiServiceEx2 extends ApiService<Ex2> {
//   @override
//   Ex2 dataFromJson(Map<String, dynamic> json) {
//     return Ex2.fromJson(json);
//   }
// }

