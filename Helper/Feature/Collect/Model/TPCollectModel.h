//
//  TPCollectModel.h
//  Helper
//
//  Created by Topredator on 2025/3/3.
//

#import <Foundation/Foundation.h>
#import "TPAnimalModel.h"
#import "TPUserModel.h"
NS_ASSUME_NONNULL_BEGIN
/// 收藏模型
@interface TPCollectModel : NSObject
/// id
@property (nonatomic, copy) NSString *collectId;
/// 宠物id
@property (nonatomic, copy) NSString *animalId;
/// 收藏者id
@property (nonatomic, copy) NSString *userId;
/// 收藏者数据
@property (nonatomic, strong,nullable) TPUserModel *user;
/// 宠物模型
@property (nonatomic, strong, nullable) TPAnimalModel *animal;
/// 创建时间
@property (nonatomic, copy) NSString *createTime;
+ (instancetype)generateWithAnimalId:(NSString *)animalId;
@end

NS_ASSUME_NONNULL_END
