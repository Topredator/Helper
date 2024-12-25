//
//  TPAnimalModel.h
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 动物模型
@interface TPAnimalModel : NSObject
/// id
@property (nonatomic, copy) NSString *animalId;
/// 编号
@property (nonatomic, copy) NSString *number;
/// 名称
@property (nonatomic, copy) NSString *name;
/// 年龄
@property (nonatomic, assign) NSInteger age;
/// 种类
@property (nonatomic, assign) TPAnimalCategory category;
/// 品种
@property (nonatomic, copy) NSString *breed;
/// 性别
@property (nonatomic, assign) TPAnimalSexType sexType;
/// 缩略图 (1:1)
@property (nonatomic, copy) NSString *thumbImage;
/// 封面图 (5:2)
@property (nonatomic, copy) NSString *coverImage;
/// 是否绝育
@property (nonatomic, assign, getter=isSterilization) BOOL sterilization;
/// 是否驱虫
@property (nonatomic, assign, getter=isDeworming) BOOL deworming;
/// 是否打过疫苗
@property (nonatomic, assign, getter=isVaccine) BOOL vaccine;
/// 创建时间
@property (nonatomic, copy) NSString *createTime;
@end

NS_ASSUME_NONNULL_END
