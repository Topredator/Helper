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

/// 公告类型
typedef NS_ENUM(NSUInteger, TPAnnouncementType) {
    /// 新闻类型
    TPAnnouncementTypeNews,
    /// 平台信息
    TPAnnouncementTypePlatform,
    /// 第三方
    TPAnnouncementTypeThirdParty,
};

#endif /* TPHelperEnum_h */
