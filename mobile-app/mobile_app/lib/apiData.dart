import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_models/status.dart';
import 'api_models/toggle.dart';

String blindStatus = "http://csci4390.ddns.net/api/v1/blind/status",
    blindOpen = "http://csci4390.ddns.net/api/v1/blind/open",
    blindClose = "http://csci4390.ddns.net/api/v1/blind/close";

class ApiEndpoints {
  static Future<Status> getStatus() async {
    // var response = await http.get(Uri.encodeFull(blindStatus), headers: {
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer jason-token'
    // }).then(
    //   if (response.statusCode == 200) {
    //     print(json.decode(response.body));
    //     // List status = json.decode(response.body);
    //     Map responseBody = json.decode(response.body);
    //     return responseBody["status"];
    //   } else {
    //     print('HTTP Status Code: ${response.statusCode}');
    //     throw Exception('Failed to load status');
    //   }
    // );

    var response = await http.get(Uri.encodeFull(blindStatus), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer jason-token'
    });

    if (response.statusCode == 200) {
      return Status.fromJson(jsonDecode(response.body));
    } else {
      print('HTTP Status Code: ${response.statusCode}');
      throw Exception('Failed to load status');
    }
  }

  static Future<Toggle> openBlinds() async {
    var response = await http.put(Uri.encodeFull(blindOpen), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer jason-token'
    });

    if (response.statusCode == 200) {
      return Toggle.fromJson(jsonDecode(response.body));
    } else {
      print('HTTP Status Code: ${response.statusCode}');
      throw Exception('Failed to load status');
    }
  }

  static Future<Toggle> closeBlinds() async {
    var response = await http.put(Uri.encodeFull(blindClose), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer jason-token'
    });

    if (response.statusCode == 200) {
      return Toggle.fromJson(jsonDecode(response.body));
    } else {
      print('HTTP Status Code: ${response.statusCode}');
      throw Exception('Failed to load status');
    }
  }
}
