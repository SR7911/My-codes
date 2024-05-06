#import "TestbotPlugin.h"
#if __has_include(<testbot/testbot-Swift.h>)
#import <testbot/testbot-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "testbot-Swift.h"
#endif

@implementation TestbotPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTestbotPlugin registerWithRegistrar:registrar];
}
@end
