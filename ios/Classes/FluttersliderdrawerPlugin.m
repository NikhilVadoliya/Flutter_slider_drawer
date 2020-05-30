#import "FluttersliderdrawerPlugin.h"
#if __has_include(<fluttersliderdrawer/fluttersliderdrawer-Swift.h>)
#import <fluttersliderdrawer/fluttersliderdrawer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fluttersliderdrawer-Swift.h"
#endif

@implementation FluttersliderdrawerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFluttersliderdrawerPlugin registerWithRegistrar:registrar];
}
@end
