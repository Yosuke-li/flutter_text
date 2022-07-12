#import "FlutterHeepayPlugin.h"
#if __has_include(<flutter_heepay/flutter_heepay-Swift.h>)
#import <flutter_heepay/flutter_heepay-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_heepay-Swift.h"
#endif

@implementation FlutterHeepayPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterHeepayPlugin registerWithRegistrar:registrar];
}
@end
