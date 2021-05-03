import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


// Jason's Motor
// String blindStatus = "http://csci4390.ddns.net/api/v1/blind/status",
//          blindOpen = "http://csci4390.ddns.net/api/v1/blind/open",
//          blindClose = "http://csci4390.ddns.net/api/v1/blind/close",
//          percent = "http://csci4390.ddns.net/api/v1/blind/percent";

// Luis's Motor
String blindStatus = "http://smartblind.ddns.net/api/v1/blind/status",
         blindOpen = "http://smartblind.ddns.net/api/v1/blind/open",
         blindClose = "http://smartblind.ddns.net/api/v1/blind/close",
         percent = "http://smartblind.ddns.net/api/v1/blind/percent";

enum BlindStatusStates {
  Open,
  InProgress,
  Closed,
  Failure
}

class ApiEndpoints {
  BlindStatusStates currentStatus;
  int currentPercentage;

  static Future<String> getStatus(http.Client client) async {
    var response = await http.get(Uri.encodeFull(blindStatus), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer jason-token'
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["status"].toString();
    } else {
      print('HTTP Status Error Code: ${response.statusCode}');
      throw Exception('Failed to fetch status');
    }
  }

  static Future<String> openBlinds(http.Client client) async {
    var response = await http.put(Uri.encodeFull(blindOpen), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer jason-token'
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["result"].toString();
    } else {
      print('HTTP Status Error Code: ${response.statusCode}');
      throw Exception('Failed to open blinds');
    }
  }

  static Future<String> closeBlinds(http.Client client) async {
    var response = await http.put(Uri.encodeFull(blindClose), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer jason-token'
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["result"].toString();
    } else {
      print('HTTP Status Error Code: ${response.statusCode}');
      throw Exception('Failed to close blinds');
    }
  }

  static Future<String> moveToPercentage(http.Client client, int newPercent) async {
    var response = await http.put(Uri.encodeFull("${percent}?percentage=${newPercent}"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer jason-token'
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["result"].toString();
    } else {
      print('HTTP Status Error Code: ${response.statusCode}');
      throw Exception('Failed to move blinds to ${newPercent} percent');
    }
  }

  static Future<int> getPercent(http.Client client) async {
    var response = await http.get(Uri.encodeFull(percent), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer jason-token'
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return int.parse(json["percentage"].toString());
    } else {
      print('HTTP Status Error Code: ${response.statusCode}');
      throw Exception('Failed to fetch current percent');
    }
  }
}