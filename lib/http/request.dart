import 'dart:convert';
import 'package:http/http.dart' as http;
import './api.dart';

class Request {
  static Future requestGet(url,
      {String baseurl = '', required Map<String, dynamic> params}) async {
    late String base;
    base = (baseurl.isEmpty ? baseURL['url1'] : baseurl)!;
    var api = Uri.https(base, url, params);
    var response = await http.get(api);
    var jsonResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
