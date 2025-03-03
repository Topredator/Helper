//
//  TPPublishModel.h
//  Helper
//
//  Created by Topredator on 2025/2/21.
//

#import <Foundation/Foundation.h>
#import "TPPublishModule.h"
#import "TPUserModel.h"
#import "TPAnimalModel.h"
NS_ASSUME_NONNULL_BEGIN

/// 发布模型
@interface TPPublishModel : NSObject
@property (nonatomic, copy) NSString *publishId;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 内容
@property (nonatomic, copy) NSString *content;
/// 发布人id
@property (nonatomic, copy, nullable) NSString *userId;
/// 发布用户
@property (nonatomic, strong, nullable) TPUserModel *user;
/// 类型
@property (nonatomic, assign) TPPublishType type;
/// 宠物id
@property (nonatomic, copy, nullable) NSString *animalId;
/// 宠物信息
@property (nonatomic, strong, nullable) TPAnimalModel *animal;
/// 图片
@property (nonatomic, copy, nullable) NSString *image;
/// 详情图片
@property (nonatomic, copy) NSString *detailImages;
/// 发布时间
@property (nonatomic, copy) NSString *createTime;
+ (instancetype)modelWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
