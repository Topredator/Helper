//
//  TPAdoptItemVC.h
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPBaseTableVC.h"

/// 领养类型
typedef NS_ENUM(NSUInteger, TPHelpItemType) {
    /// 全部
    TPHelpItemTypeAll,
    /// 待救助
    TPHelpItemToBeRescued,
    /// 康复中
    TPHelpItemInRecovery,
    /// 待领养
    TPHelpItemPendingAdoption
};

/// 领养 item 控制器
@interface TPHelpItemVC : TPBaseTableVC
/// 类型
@property (nonatomic, assign) TPHelpItemType itemType;
+ (instancetype)itemType:(TPHelpItemType)itemType;
@end


