//
//  TPUserModel.m
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import "TPUserModel.h"
@implementation TPUserModel
- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}
+ (instancetype)userAccount:(NSString *)account pwd:(NSString *)pwd type:(TPUserType)type {
    return [self userAccount:account pwd:pwd name:nil type:type];
}
+ (instancetype)userAccount:(NSString *)account pwd:(NSString *)pwd name:(NSString *)name type:(TPUserType)type {
    TPUserModel *model = [self new];
    model.account = account;
    model.password = pwd;
    model.userType = type;
    model.name = name;
    model.userId = [NSString stringWithFormat:@"%ld-%@-%d", type, [[NSDate now] tp_stringWithFormat:@"yyyyMMddHHmmss"], arc4random_uniform(10000)];
    model.token = [[NSString stringWithFormat:@"%ld-%@-%d", type, [[NSDate now] tp_stringWithFormat:@"yyyyMMddHHmmss"], arc4random_uniform(10000)] tp_MD5];
    return model;
}

@end
