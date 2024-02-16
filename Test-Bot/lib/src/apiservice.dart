import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class APICalls {
  static apicall({requests, param, uri, label}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('$requests', Uri.parse(uri));
      request.body = json.encode(param);
      print("=====$param");
      request.headers.addAll(headers);

      final http.StreamedResponse response = await request.send();
      final result = await http.Response.fromStream(response);
      print("$label :: =====URI=====>$requests :: $uri");

      if (response.statusCode == 200) {
        print("$label :: =====PARAM=====>$param");
        print("$label :: ======success====${result.body}==");
        return [true, result.body];
      } else {
        print("$label :: ====reportNamefailed===${result.statusCode}");
        print("$label :: ===response====${result.body}");
        return [false, result.body];
      }
    } catch (e) {
      print("$label :: ===failed===$e");
      return [false, e];
    }
  }
}
