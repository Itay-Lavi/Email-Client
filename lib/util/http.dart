import 'package:email_client/util/compression.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum HttpMethod { get, post, patch, put }

Future<dynamic> httpRequest(
    Uri url, Map<String, String> headers, HttpMethod method,
    [String? body]) async {
  late http.Response response;
  const timeoutSec = 20;

  if (body != null) {
    body = await compressData(body);
  }

  switch (method) {
    case HttpMethod.post:
      response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: timeoutSec));
      break;

    case HttpMethod.get:
      response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: timeoutSec));
      break;

    case HttpMethod.patch:
      response = await http
          .patch(url, headers: headers, body: body)
          .timeout(const Duration(seconds: timeoutSec));
      break;

    case HttpMethod.put:
      response = await http
          .put(url, headers: headers, body: body)
          .timeout(const Duration(seconds: timeoutSec));
      break;

    default:
      throw UnsupportedError('Unsupported HTTP method: $method');
  }

  dynamic jsonDecoded;

  try {
    final deCompressedData = await deCompressData(response.body);

    jsonDecoded = await jsonDecode(deCompressedData);
  } catch (_) {}

  if (response.statusCode != 200) {
    final throwText = jsonDecoded != null
        ? {
            'error': 'Request failed with status: ${response.statusCode}',
            ...jsonDecoded
          }
        : {'error': 'Request failed with status: ${response.statusCode}'};
    throw ArgumentError(throwText);
  }

  return jsonDecoded;
}
