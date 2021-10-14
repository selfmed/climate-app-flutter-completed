import 'dart:convert';

import 'package:http/http.dart' as http;

class NetwrokUtility {
  final String url;

  NetwrokUtility({required this.url});

  Future<dynamic> getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // 200 means success
        var decodedData = jsonDecode(response.body);
        return decodedData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
