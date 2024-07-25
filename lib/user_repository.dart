import 'package:demo_labs_project/users.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserRepository {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://fake-json-api.mock.beeceptor.com/users'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
