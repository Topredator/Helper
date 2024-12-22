//
//  TPNotifyAnnouncementModel.h
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 公告 模型
@interface TPNotifyAnnouncementModel : NSObject
/// 公告id
@property (nonatomic, copy) NSString *announcementId;
/// 主题
@property (nonatomic, copy) NSString *theme;
/// 内容
@property (nonatomic, copy) NSString *details;
/// 发布时间
@property (nonatomic, copy) NSString *createTime;
/// 图片
@property (nonatomic, copy) NSString *image;
/// 类型
@property (nonatomic, assign) TPAnnouncementType type;
/// 链接地址
@property (nonatomic, copy) NSString *url;

/// 发布人id
@property (nonatomic, copy) NSString *publisherId;
/// 发布人名称
@property (nonatomic, copy) NSString *publisherName;
/// 发布人头像
@property (nonatomic, copy) NSString *publisherAvatar;
/// 发布人联系方式
@property (nonatomic, copy) NSString *publisherPhone;

+ (instancetype)modelWithTheme:(NSString *)theme details:(NSString *)details type:(TPAnnouncementType)type;

@end

NS_ASSUME_NONNULL_END
