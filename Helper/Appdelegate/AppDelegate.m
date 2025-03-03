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



@interface AA : NSObject
@property (nonatomic, strong) NSMutableArray *arr;
@end

@implementation AA
- (void)addObject {
    [self.arr addObject:@"11"];
    [self.arr addObject:@"22"];
}
- (NSMutableArray *)arr {
    if (!_arr) {
        _arr = @[].mutableCopy;
    }
    return _arr;
}

@end

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化数据库
    [self tp_setupDatabase];
    // 初始化窗口及根视图
    [self tp_initWindow];
    
    
    return YES;
}

@end
