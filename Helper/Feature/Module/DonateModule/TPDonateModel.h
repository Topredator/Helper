//
//  TPDonateModel.h
//  Helper
//
//  Created by Topredator on 2025/3/21.
//

#import <Foundation/Foundation.h>
#import "TPAnimalModel.h"
#import "TPUserModel.h"
NS_ASSUME_NONNULL_BEGIN


/// 物品模型
@interface TPDonateItemModel : NSObject
/// 物品id
@property (nonatomic, assign) NSInteger itemId;
/// 物品分类id
@property (nonatomic, assign) NSInteger categoryId;
/// 物品名称
@property (nonatomic, copy) NSString *itemName;
/// 数量
@property (nonatomic, assign) NSInteger quantity;
@end

/// 物品分类模型
@interface TPDonateCategoryModel : NSObject
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, strong) NSArray <TPDonateItemModel *>* items;
@end


/// 捐赠数据模型
@interface TPDonateModel : NSObject
/// 捐赠id
@property (nonatomic, copy) NSString *donateId;
/// 捐赠人id
@property (nonatomic, copy) NSString *donaterId;
/// 捐赠人信息
@property (nonatomic, strong) TPUserModel *donater;
/// 被捐赠人id
@property (nonatomic, copy) NSString *doneeId;
/// 被捐赠人信息
@property (nonatomic, strong) TPUserModel *donee;
/// 宠物id
@property (nonatomic, copy) NSString *animalId;
/// 动物信息
@property (nonatomic, strong) TPAnimalModel *animal;
/// 创建时间
@property (nonatomic, copy) NSString *createTime;
/// 快递编号
@property (nonatomic, copy) NSString *expressNumber;
+ (instancetype)model;
@end


/// 操作模型
@interface TPDonateOperate : NSObject
@property (nonatomic, strong) TPDonateModel *donate;
@property (nonatomic, copy) NSArray <TPDonateCategoryModel *> *categorys;
@end

NS_ASSUME_NONNULL_END
