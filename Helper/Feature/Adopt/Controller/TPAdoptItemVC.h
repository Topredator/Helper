//
//  TPAdoptItemVC.h
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPBaseTableVC.h"

/// 领养类型
typedef NS_ENUM(NSUInteger, TPAdoptItemType) {
    /// 全部
    TPAdoptItemTypeAll,
    /// 猫
    TPAdoptItemTypeCat,
    /// 狗
    TPAdoptItemTypeDog,
    /// 其他
//    TPAdoptItemTypeOther,
};

/// 领养 item 控制器
@interface TPAdoptItemVC : TPBaseTableVC
/// 类型
@property (nonatomic, assign) TPAdoptItemType itemType;
+ (instancetype)itemType:(TPAdoptItemType)itemType;
@end


