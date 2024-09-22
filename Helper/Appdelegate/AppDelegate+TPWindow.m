//
//  AppDelegate+TPWindow.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "AppDelegate+TPWindow.h"
#import "TPRootVC.h"

@implementation AppDelegate (TPWindow)
- (void)tp_initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [TPRootVC new];
    [self.window makeKeyAndVisible];
}
@end
