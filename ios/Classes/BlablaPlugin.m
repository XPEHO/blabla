#import "BlablaPlugin.h"
#if __has_include(<blabla/blabla-Swift.h>)
#import <blabla/blabla-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "blabla-Swift.h"
#endif

@implementation BlablaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBlablaPlugin registerWithRegistrar:registrar];
}
@end
