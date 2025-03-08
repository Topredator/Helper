//
//  TPAddressModel.m
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import "TPAddressModel.h"

@implementation TPAddressModel
+ (instancetype)generateModel {
    TPAddressModel *model = [TPAddressModel new];
    NSString *time = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
    model.createTime = time;
    model.userId = TPUserManager.manager.user.userId;
    model.addressId = [[NSString stringWithFormat:@"address_%@", time] tp_MD5];
    
    return model;
}
@end
