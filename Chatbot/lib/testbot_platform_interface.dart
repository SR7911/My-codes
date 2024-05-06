import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'testbot_method_channel.dart';

abstract class TestbotPlatform extends PlatformInterface {
  /// Constructs a TestbotPlatform.
  TestbotPlatform() : super(token: _token);

  static final Object _token = Object();

  static TestbotPlatform _instance = MethodChannelTestbot();

  /// The default instance of [TestbotPlatform] to use.
  ///
  /// Defaults to [MethodChannelTestbot].
  static TestbotPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TestbotPlatform] when
  /// they register themselves.
  static set instance(TestbotPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
