#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@import UIKit;
@import Firebase;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [FIRApp configure];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions]; // YES;
}
@end


//#include "AppDelegate.h"
//#include "GeneratedPluginRegistrant.h"
//
//@import UIKit;
//@import Firebase;
//@implementation AppDelegate
//
//- (BOOL)application:(UIApplication *)application
//    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [FIRApp configure];
//    return YES;
//  //[GeneratedPluginRegistrant registerWithRegistry:self];
//  // Override point for customization after application launch.
//  //return [super application:application didFinishLaunchingWithOptions:launchOptions];
//}
//
//@end
