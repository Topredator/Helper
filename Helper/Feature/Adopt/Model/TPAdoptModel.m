//
//  TPAdoptModel.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPAdoptModel.h"

@implementation TPAdoptModel
+ (instancetype)adoptName:(NSString *)name category:(TPAnimalCategory)category sex:(TPAnimalSexType)sex {
    TPAdoptModel *model = [TPAdoptModel new];
    model.name = name;
    model.age = (arc4random() % 5) + 1;
    model.category = category;
    model.sexType = sex;
    model.breed = @"英短";
    model.sterilization = (arc4random() % 2);
    model.deworming = (arc4random() % 2);
    model.vaccine = (arc4random() % 2);
    model.thumbImage = [NSString stringWithFormat:@"%@%u", category == TPAnimalCategoryCat ? @"cat_avatar_" : @"dog_avatar_", arc4random() % 30 + 1];
    model.beAdopted = (arc4random() % 2);
    model.coverImage = [NSString stringWithFormat:@""];
    return model;
}
@end
