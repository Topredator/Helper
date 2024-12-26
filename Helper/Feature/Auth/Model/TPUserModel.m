//
//  TPUserModel.m
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import "TPUserModel.h"
@implementation TPUserModel
+ (instancetype)userAccount:(NSString *)account pwd:(NSString *)pwd type:(TPUserType)type {
    return [self userAccount:account pwd:pwd name:@"匿名" idCard:nil type:type];
}
+ (instancetype)userAccount:(NSString *)account
                        pwd:(NSString *)pwd
                       name:(NSString *)name
                     idCard:(NSString *)idCard
                       type:(TPUserType)type {
    TPUserModel *model = [self new];
    model.account = account;
    model.password = pwd;
    model.userType = type;
    model.name = name;
    if (idCard) {
        model.idCard = idCard;
    }
    model.avatar = [NSString stringWithFormat:@"user_avatar_%u", arc4random() % 35 + 1];
    model.userId = [account tp_MD5];
    model.token = [[NSString stringWithFormat:@"%ld-%@-%d", type, [[NSDate now] tp_stringWithFormat:@"yyyyMMddHHmmss"], arc4random_uniform(10000)] tp_MD5];
    model.createTime = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
    return model;
}

- (id)copyWithZone:(NSZone *)zone {
    return [self tp_modelCopy];
}
+ (BOOL)supportsSecureCoding {
    return YES;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    return [self tp_modelInitWithCoder:coder];
}
- (void)encodeWithCoder:(NSCoder *)coder {
    return [self tp_modelEncodeWithCoder:coder];
}
@end
