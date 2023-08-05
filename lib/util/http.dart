import 'package:http/http.dart' as http;
import 'dart:convert';

enum HttpMethod { get, post, patch, put }

Future<Map<String, dynamic>> httpRequest(
    Uri url, Map<String, String> headers, HttpMethod method,
    [String? body]) async {
  late http.Response response;

  switch (method) {
    case HttpMethod.post:
      response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 10));
      break;

    case HttpMethod.get:
      response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 10));
      break;

    case HttpMethod.patch:
      response = await http
          .patch(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 10));
      break;

    case HttpMethod.put:
      response = await http
          .put(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 10));
      break;

    default:
      throw UnsupportedError('Unsupported HTTP method: $method');
  }

  if (response.statusCode != 200) {
    throw 'Request failed with status: ${response.statusCode}';
  }

  return await jsonDecode(response.body);
}
