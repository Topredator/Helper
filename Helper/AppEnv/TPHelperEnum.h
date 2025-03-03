//
//  TPHelperEnum.h
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#ifndef TPHelperEnum_h
#define TPHelperEnum_h

/// 动物性别
typedef NS_ENUM(NSUInteger, TPAnimalSexType) {
    /// 雌性
    TPAnimalSexTypeFemale,
    /// 雄性
    TPAnimalSexTypeMale,
};


/// 动物种类
typedef NS_ENUM(NSUInteger, TPAnimalCategory) {
    /// 猫
    TPAnimalCategoryCat,
    /// 狗
    TPAnimalCategoryDog,
    /// 其他
    TPAnimalCategoryOther,
};

/// 宠物状态
typedef NS_ENUM(NSInteger, TPAnimalStatus) {
    /// 无主状态
    TPAnimalStatusUnowned,
    /// 有主状态
    TPAnimalStatusActive
};

/// 公告类型
typedef NS_ENUM(NSUInteger, TPAnnouncementType) {
    /// 新闻类型
    TPAnnouncementTypeNews,
    /// 平台信息
    TPAnnouncementTypePlatform,
    /// 第三方
    TPAnnouncementTypeThirdParty,
};

/// 动物领养申请状态
typedef NS_ENUM(NSUInteger, TPApplyStatus) {
    /// 未申请
    TPApplyStatusNone,
    /// 申请中
    TPApplyStatusApplying,
    /// 被拒绝
    TPApplyStatusBeRejected,
    /// 申请成功
    TPApplyStatusSuccess
};

/// 申请类型
typedef NS_ENUM(NSUInteger, TPApplyType) {
    /// 申请成为管理员
    TPApplyTypeAdmin,
    /// 申请领养动物
    TPApplyTypeAdopt,
};


/// 发布类型
typedef NS_ENUM(NSInteger, TPPublishType) {
    /// 链接公告
    TPPublishTypeLinkNotice,
    /// 图文公告
    TPPublishTypeGraphicNotice,
    /// 日常
    TPPublishTypeDaily,
    /// 待救助
    TPPublishTypeToBeRescued,
    /// 康复中
    TPPublishTypeInRecovery,
    /// 领养
    TPPublishTypeAdopt,
    /// 宠物相关
    TPPublishTypeAboutAnimal
};


#endif /* TPHelperEnum_h */
