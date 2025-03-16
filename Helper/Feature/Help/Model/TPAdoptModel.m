//
//  TPAdoptModel.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPAdoptModel.h"

@implementation TPAdoptModel
+ (instancetype)adopetWithAnimalId:(NSString *)animalId {
    TPAdoptModel *model = [TPAdoptModel new];
    model.animalId = animalId;
    model.publisherId = TPUserManager.manager.user.userId;
    NSInteger time =  (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000;
    model.adoptId = [NSString stringWithFormat:@"adoptId_%ld", time];
    model.createTime = [NSString stringWithFormat:@"%ld", time];
    model.applyStatus = TPApplyStatusNone;
    return model;
}
+ (instancetype)adoptName:(NSString *)name category:(TPAnimalCategory)category sex:(TPAnimalSexType)sex {
    TPAdoptModel *model = [TPAdoptModel new];
    TPAnimalModel *animalModel = [TPAnimalModel generateModel];
    animalModel.name = name;
    animalModel.category  = category;
    animalModel.sexType = sex;
    animalModel.age = (arc4random() % 5) + 1;
    animalModel.breed = @"英短";
    animalModel.sterilization = (arc4random() % 2);
    animalModel.deworming = (arc4random() % 2);
    animalModel.vaccine = (arc4random() % 2);
    animalModel.thumbImage = [NSString stringWithFormat:@"%@%u", category == TPAnimalCategoryDog ? @"dog_avatar_" : @"cat_avatar_", arc4random() % 30 + 1];
    animalModel.coverImage = [NSString stringWithFormat:@"%@%u", category == TPAnimalCategoryDog ? @"banner_dog_" : @"banner_cat_", arc4random() % 15 + 1];
    model.animal = animalModel;
    return model;
}
@end
