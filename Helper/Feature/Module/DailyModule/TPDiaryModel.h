//
//  TPDailyModel.h
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import <Foundation/Foundation.h>
#import "TPUserModel.h"

/// 日记模型
@interface TPDiaryModel : NSObject
/// 日记id
@property (nonatomic, copy) NSString *diaryId;
/// 发布用户
@property (nonatomic, strong) TPUserModel *user;
/// 发布用户的id
@property (nonatomic, copy) NSString *userId;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 内容
@property (nonatomic, copy) NSString *content;
/// 图片
@property (nonatomic, copy) NSString *image;
/// 创建时间
@property (nonatomic, copy) NSString *createTime;
+ (instancetype)modelWithTitle:(NSString *)title content:(NSString *)content;
@end


