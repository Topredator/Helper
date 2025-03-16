//
//  TPApplyModel.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPApplyModel.h"

@implementation TPApplyModel
+ (instancetype)modelWithUserId:(NSString *)userId animalId:(NSString *)animalId {
    TPApplyModel *model = [TPApplyModel new];
    NSString *time = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
    model.applyId = [[NSString stringWithFormat:@"apply_%@", time] tp_MD5];
    model.applicantId = TPUserManager.manager.user.userId;
    model.respondentId = userId;
    model.animalId = animalId;
    model.createTime = time;
    model.type = TPApplyTypeAdopt;
    model.applyStatus = TPApplyStatusApplying;
    return model;
}
@end
