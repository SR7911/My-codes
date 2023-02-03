import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:testbot/src/color.dart';

// 1. compress file and get Uint8List
Future<Uint8List> compressFile(File file, context) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    minWidth: 2300,
    minHeight: 1500,
    quality: 10,
    // rotate: 90,
  );
  for (int i = 70; i >= 1; i--) {
    result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 500,
      minHeight: 500,
      quality: i,
      // rotate: 90,
    );
    final bytes = result!.lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    if (kb < 90) {
      print('image size in Kb: $kb');
      break;
    }
  }
  return result!;
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

showAlertDialog(BuildContext context) {
  ResponsiveApp.setMq(context);

  Get.forceAppUpdate();
  Get.appUpdate();
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: new Row(
          children: [
            SizedBox(
              width: 10,
            ),
            CircularProgressIndicator(
              color: primaryClr,
            ),
            SizedBox(
              width: 25,
            ),
            Text("Loading...")
          ],
        ),
      );
    },
  );

  Get.appUpdate();
  Get.forceAppUpdate();
  ResponsiveApp.setMq(context);
}

class ResponsiveApp {
  static MediaQueryData? _mediaQueryData;

  MediaQueryData get mq => _mediaQueryData!;

  static void setMq(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }
}
