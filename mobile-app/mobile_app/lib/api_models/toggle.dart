import 'package:flutter/foundation.dart';

/*
  This model will apply to any endpoint returning JSON structure like the following:
  {"result" : "opened/closed"}
*/

class Toggle {
  final String result;

  Toggle({
    @required this.result,
  });

  factory Toggle.fromJson(Map<String, dynamic> json) {
    return Toggle(result: json['result'] as String);
  }
}
