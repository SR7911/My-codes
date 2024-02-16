#ifndef FLUTTER_PLUGIN_TESTBOT_PLUGIN_H_
#define FLUTTER_PLUGIN_TESTBOT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace testbot {

class TestbotPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  TestbotPlugin();

  virtual ~TestbotPlugin();

  // Disallow copy and assign.
  TestbotPlugin(const TestbotPlugin&) = delete;
  TestbotPlugin& operator=(const TestbotPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace testbot

#endif  // FLUTTER_PLUGIN_TESTBOT_PLUGIN_H_
