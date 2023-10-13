import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:archive/archive.dart';

Future<String> deCompressData(data) async {
  String deCompressFunc() {
    List<int> gzipBytes = base64.decode(data.toString());
    List<int> decompressed = GZipDecoder().decodeBytes(gzipBytes);
    return json.decode(utf8.decode(decompressed));
  }

  String decodedData;
  if (kIsWeb) {
    decodedData = deCompressFunc();
  } else {
    decodedData = await Isolate.run(deCompressFunc);
  }

  return decodedData;
}

Future<String> compressData(dynamic data) async {
  String compressFunc() {
    List<int> utf = utf8.encode(data);
    List<int> compressed = GZipEncoder().encode(utf)!;
    return base64.encode(compressed);
  }

  String encodedData;
  if (kIsWeb) {
    encodedData = compressFunc();
  } else {
    encodedData = await Isolate.run(compressFunc);
  }

  return encodedData;
}
