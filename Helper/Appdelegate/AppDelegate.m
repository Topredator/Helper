//
//  AppDelegate.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "AppDelegate.h"
#import "AppDelegate+TPWindow.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 初始化窗口及根视图
    [self tp_initWindow];
    return YES;
}

@end
