//
//  TPCollectModel.m
//  Helper
//
//  Created by Topredator on 2025/3/3.
//

#import "TPCollectModel.h"

@implementation TPCollectModel

+ (instancetype)generateWithAnimalId:(NSString *)animalId {
    TPCollectModel *model = [TPCollectModel new];
    model.animalId = animalId;
    model.userId = TPUserManager.manager.user.userId;
    NSString *time = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
    model.createTime = time;
    model.collectId = [[NSString stringWithFormat:@"collect_%@", time] tp_MD5];
    return model;
}
@end
