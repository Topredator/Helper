//
//  TPHomeBannerModel.m
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import "TPHomeBannerModel.h"

@implementation TPHomeBannerModel
+ (instancetype)bannerWithName:(NSString *)name {
    TPHomeBannerModel *model = [TPHomeBannerModel new];
    model.image = name;
    return model;
}
@end
