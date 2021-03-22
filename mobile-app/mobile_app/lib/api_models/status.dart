import 'package:flutter/foundation.dart';

/*
  This model will apply to any endpoint returning JSON structure like the following:
  {"status" : "open/close"}
*/

class Status {
  final String status;

  Status({
    @required this.status,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(status: json['status'] as String);
  }
}
