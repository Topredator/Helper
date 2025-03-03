//
//  TPApplyModel.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPApplyModel.h"

@implementation TPApplyModel
+ (instancetype)modelWithUserId:(NSString *)userId {
    TPApplyModel *model = [TPApplyModel new];
    NSString *time = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
    model.applyId = [[NSString stringWithFormat:@"applyId_%@", time] tp_MD5];
    model.userId = userId;
    model.type = TPApplyTypeAdmin;
    model.applyStatus = TPApplyStatusApplying;
    return model;
}
+ (instancetype)modelWithUserId:(NSString *)userId adoptId:(NSString *)adoptId adminId:(nonnull NSString *)adminId {
    TPApplyModel *model = [TPApplyModel new];
    NSString *time = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
    model.applyId = [[NSString stringWithFormat:@"applyId_%@", time] tp_MD5];
    model.userId = userId;
    model.type = TPApplyTypeAdopt;
    model.adoptId = adoptId;
    model.adminId = adminId;
    model.applyStatus = TPApplyStatusApplying;
    return model;
}
@end
