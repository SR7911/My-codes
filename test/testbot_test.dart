import 'package:flutter_test/flutter_test.dart';
import 'package:testbot/testbot_platform_interface.dart';
import 'package:testbot/testbot_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTestbotPlatform
    with MockPlatformInterfaceMixin
    implements TestbotPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TestbotPlatform initialPlatform = TestbotPlatform.instance;

  test('$MethodChannelTestbot is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTestbot>());
  });

  test('getPlatformVersion', () async {
    // Testbot testbotPlugin = Testbot();
    MockTestbotPlatform fakePlatform = MockTestbotPlatform();
    TestbotPlatform.instance = fakePlatform;

    // expect(await testbotPlugin.getPlatformVersion(), '42');
  });
}
