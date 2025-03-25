//
//  TPDonateModel.m
//  Helper
//
//  Created by Topredator on 2025/3/21.
//

#import "TPDonateModel.h"

@implementation TPDonateItemModel

@end

@implementation TPDonateCategoryModel
+ (nullable NSDictionary<NSString *, id> *)tp_modelContainerPropertyGenericClass {
    return @{
        @"items": TPDonateItemModel.class
        
    };
}
@end

@implementation TPDonateModel
+ (instancetype)model {
    TPDonateModel *model = [TPDonateModel new];
    NSString *time = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
    model.donateId = [[NSString stringWithFormat:@"donate_%@", time] tp_MD5];
    model.createTime = time;
    return model;
}
@end

@implementation TPDonateOperate


@end
