//
//  TPApplyModel.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPApplyModel.h"

@implementation TPApplyModel
+ (instancetype)modelWithUserId:(NSString *)userId type:(TPApplyType)type adoptId:(nonnull NSString *)adoptId {
    TPApplyModel *model = [TPApplyModel new];
    NSString *time = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
    model.applyId = [[NSString stringWithFormat:@"applyId_%@", time] tp_MD5];
    model.userId = userId;
    model.type = type;
    model.adoptId = adoptId;
    model.applyStatus = TPApplyStatusApplying;
    return model;
}
@end
