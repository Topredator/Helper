//
//  AppDelegate+TPWindow.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "AppDelegate+TPWindow.h"
#import "TPNavigationController.h"
#import "TPRootVC.h"
#import "TPLoginVC.h"
@implementation AppDelegate (TPWindow)
- (void)tp_initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    [self tp_resetWindow];
}

- (void)tp_resetWindow {
    if (!TPUserManager.manager.isLogin || ![TPCommonUD UDBoolKey:kTPHelperAutoLoginKey]) {
        self.window.rootViewController = [[TPNavigationController alloc] initWithRootViewController:TPLoginVC.new];
    } else {
        self.window.rootViewController = [TPRootVC new];
    }
    [self.window makeKeyAndVisible];
}
- (void)tp_resetWindowAfterLogin {
    self.window.rootViewController = [TPRootVC new];
    [self.window makeKeyAndVisible];
}
@end
