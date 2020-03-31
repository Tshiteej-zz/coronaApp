import 'dart:convert';
import 'package:http/http.dart' as http;
import 'User.dart';

class Services {
  // static const String url = 'https://jsonplaceholder.typicode.com/users';

  // static Future<List<User>> getUsers() async {
  //   try {
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       List<User> list = parseUsers(response.body);
  //       return list;
  //     } else {
  //       throw Exception("Error");
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  // static List<User> parseUsers(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<User>((json) => User.fromJson(json)).toList();
  // }

  static const String url = 'https://corona-api.com/countries';

  static Future<List<PageData>> getData() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<PageData> list = parseData(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<PageData> parseData(String responseBody) {
    final parsed = json.decode(responseBody)['data'];
    // .cast<String, dynamic>();
    return parsed.map<PageData>((json) => PageData.fromJson(json)).toList();
  }
}
