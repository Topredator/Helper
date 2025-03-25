//
//  TPDonateModule.h
//  Helper
//
//  Created by Topredator on 2025/3/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 捐赠表 名称
#define TABLE_NAME_DONATE @"Donate_"
/// 捐赠详情表
#define TABLE_NAME_DONATE_DETAIL @"Donate_detail_"


/// 捐赠分类 表名称
#define TABLE_NAME_DONATE_CATEGORY @"Donate_category_"
/// 捐赠 物品信息表
#define TABLE_NAME_DONATE_CATEGORY_ITEM @"Donate_category_item_"

/// 捐赠消息类型
typedef NS_ENUM(NSInteger, TPDonateModuleMessageType) {
    /// 查询用户捐赠信息
    TPDonateFetchUserDonates = 700000,
    TPDonateFetchUserMoreDonates,
    /// 通用
    TPDonateFetchCommonDonates,
    
    /// 查询所有分类
    TPDonateFetchAllCategories,
    /// 宠物捐赠
    TPDonatePetDonation,
};

/// 捐赠模块
@interface TPDonateModule : NSObject <TPDBModuleProtocol>

@end

NS_ASSUME_NONNULL_END
