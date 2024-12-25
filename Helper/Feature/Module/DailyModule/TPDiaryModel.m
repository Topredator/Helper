//
//  TPDailyModel.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPDiaryModel.h"

@implementation TPDiaryModel
+ (instancetype)modelWithTitle:(NSString *)title content:(NSString *)content {
    TPDiaryModel *model = [TPDiaryModel new];
    NSString *time = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
    model.diaryId = [[NSString stringWithFormat:@"%@_%@", title, time] tp_MD5];
    model.title = title;
    model.content = content;
    model.userId = TPUserManager.manager.user.userId;
    model.image = [NSString stringWithFormat:@"home_diary_%u", arc4random() % 25 + 1];
    model.createTime = time;
    return model;
}
@end
