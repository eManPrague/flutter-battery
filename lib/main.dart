import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const platform = const MethodChannel('battery');

void main() {
  platform
      .invokeMethod('getBatteryLevel')
      .then((result) => 'Battery level at $result %.')
      .catchError((error) => "Failed to get battery level: '${error.message}'.")
      .then((msg) => runApp(new Center(
            child: new Text(
              msg,
              textDirection: TextDirection.ltr,
            ),
          )));
}
