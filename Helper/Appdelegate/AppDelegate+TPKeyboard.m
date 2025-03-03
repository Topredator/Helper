//
//  AppDelegate+TPKeyboard.m
//  Helper
//
//  Created by Topredator on 2025/2/21.
//

#import "AppDelegate+TPKeyboard.h"

@implementation AppDelegate (TPKeyboard)
- (void)tp_configKeyBoard {
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = YES;
    IQKeyboardManager.sharedManager.enableAutoToolbar = NO;
}
@end
