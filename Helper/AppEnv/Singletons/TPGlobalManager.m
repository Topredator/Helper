//
//  TPGlobalManager.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPGlobalManager.h"

static NSString *kTPGlobalFirstLoad = @"com.helper.firstload";

static TPGlobalManager *manager = nil;
@implementation TPGlobalManager
+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [TPGlobalManager new];
    });
    return manager;
}
- (BOOL)isFirstLoad {
    return [TPCommonUD UDBoolKey:kTPGlobalFirstLoad];
}
- (void)setFirstLoad:(BOOL)firstLoad {
    [TPCommonUD UDBool:firstLoad key:kTPGlobalFirstLoad];
}
@end
