//
//  TPAdoptModel.h
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import <Foundation/Foundation.h>

/// 领养模型
@interface TPAdoptModel : NSObject <TPJsonModel>
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
@property (nonatomic, assign) BOOL isSterilization;
/// 是否驱虫
@property (nonatomic, assign) BOOL isDeworming;
/// 是否打过疫苗
@property (nonatomic, assign) BOOL isVaccine;
/// 是否被领养
@property (nonatomic, assign) BOOL beAdopted;

/// 领养人id
@property (nonatomic, copy) NSString *adoptedId;
/// 领养人姓名
@property (nonatomic, copy) NSString *adoptedName;
/// 领养人头像
@property (nonatomic, copy) NSString *adoptedAvatar;
/// 领养人联系方式
@property (nonatomic, copy) NSString *adoptedPhone;

/// 发布者id
@property (nonatomic, copy) NSString *publisherId;
/// 发布者名称
@property (nonatomic, copy) NSString *publisherName;
/// 发布者头像
@property (nonatomic, copy) NSString *publisherAvatar;
/// 发布者联系方式
@property (nonatomic, copy) NSString *publisherPhone;


+ (instancetype)adoptName:(NSString *)name category:(TPAnimalCategory)category sex:(TPAnimalSexType)sex;

@end


