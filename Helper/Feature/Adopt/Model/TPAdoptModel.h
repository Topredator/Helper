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
@property (nonatomic, assign, getter=isSterilization) BOOL sterilization;
/// 是否驱虫
@property (nonatomic, assign, getter=isDeworming) BOOL deworming;
/// 是否打过疫苗
@property (nonatomic, assign, getter=isVaccine) BOOL vaccine;
/// 是否被领养
@property (nonatomic, assign) BOOL beAdopted;
/// 领养申请状态
@property (nonatomic, assign) TPApplyStatus applyStatus;
/// 领养人id
@property (nonatomic, copy) NSString *adopterId;
/// 领养人姓名
@property (nonatomic, copy) NSString *adopterName;
/// 领养人头像
@property (nonatomic, copy) NSString *adopterAvatar;
/// 领养人联系方式
@property (nonatomic, copy) NSString *adopterPhone;

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


