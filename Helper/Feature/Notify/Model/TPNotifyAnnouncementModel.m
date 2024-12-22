//
//  TPNotifyAnnouncementModel.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPNotifyAnnouncementModel.h"

@implementation TPNotifyAnnouncementModel
+ (instancetype)modelWithTheme:(NSString *)theme details:(NSString *)details type:(TPAnnouncementType)type {
    TPNotifyAnnouncementModel *model = [TPNotifyAnnouncementModel new];
    model.theme = theme;
    model.details = details;
    model.type = type;
    model.url = type == TPAnnouncementTypeNews ? @"https://baike.baidu.com/item/%E7%8B%B8%E8%8A%B1%E7%8C%AB/987844?fr=ge_ala" : nil;
    model.image = @"";
    return model;
}
@end
