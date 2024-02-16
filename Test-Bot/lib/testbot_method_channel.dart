import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'testbot_platform_interface.dart';

/// An implementation of [TestbotPlatform] that uses method channels.
class MethodChannelTestbot extends TestbotPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('testbot');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
