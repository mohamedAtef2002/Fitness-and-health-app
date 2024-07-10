// lib/network_service.dart
import 'package:http/http.dart' as http;

class NetworkService {
  Future<http.Response> createPost(String url,
      {Map<String, String>? headers, body}) async {
    return await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
  }
}
