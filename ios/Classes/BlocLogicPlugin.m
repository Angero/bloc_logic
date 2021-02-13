#import "BlocLogicPlugin.h"
#if __has_include(<bloc_logic/bloc_logic-Swift.h>)
#import <bloc_logic/bloc_logic-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "bloc_logic-Swift.h"
#endif

@implementation BlocLogicPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBlocLogicPlugin registerWithRegistrar:registrar];
}
@end
