//
//  AppDelegate.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "AppDelegate.h"
#import "AppDelegate+TPWindow.h"
#import "AppDelegate+TPDatabase.h"
#import "AppDelegate+TPKeyboard.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化数据库
    [self tp_setupDatabase];
    // 初始化窗口及根视图
    [self tp_initWindow];
    // 初始化自定义数据
    [self tp_initCustomInfo];
    return YES;
}

@end
