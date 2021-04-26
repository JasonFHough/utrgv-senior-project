import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app/api_models/status.dart';
import 'package:mobile_app/api_models/toggle.dart';

String blindStatus = "http://csci4390.ddns.net/api/v1/blind/status",       // http://smartblind.ddns.net/api/v1/blind/status
         blindOpen = "http://csci4390.ddns.net/api/v1/blind/open",         // http://smartblind.ddns.net/api/v1/blind/open
         blindClose = "http://csci4390.ddns.net/api/v1/blind/close";       // http://smartblind.ddns.net/api/v1/blind/close


enum BlindStatusStates {
  Open,
  InProgress,
  Closed,
  Failure
}

class ApiEndpoints {
  BlindStatusStates currentStatus;

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
}
