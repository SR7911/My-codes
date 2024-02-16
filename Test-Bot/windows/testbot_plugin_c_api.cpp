#include "include/testbot/testbot_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "testbot_plugin.h"

void TestbotPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  testbot::TestbotPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
