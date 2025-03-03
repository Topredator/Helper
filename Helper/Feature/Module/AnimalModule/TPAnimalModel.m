//
//  TPAnimalModel.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPAnimalModel.h"

@implementation TPAnimalModel
+ (instancetype)generateModel {
    TPAnimalModel *model = [TPAnimalModel new];
    NSInteger time =  (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000;
    model.animalId = [[NSString stringWithFormat:@"animal_%ld", time] tp_MD5];
    model.number = [NSString stringWithFormat:@"animal_%ld", time];
    model.category = TPAnimalCategoryCat;
    model.sexType = TPAnimalSexTypeFemale;
    model.createTime = [NSString stringWithFormat:@"%ld", time];
    return model;
}
@end
