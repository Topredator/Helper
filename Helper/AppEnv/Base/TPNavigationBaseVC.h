//
//  TPNavigationBaseVC.h
//  Helper
//
//  Created by Topredator on 2024/10/14.
//

#import "TPBaseVC.h"
#import "TPNavigationView.h"

NS_ASSUME_NONNULL_BEGIN

/// 具有导航视图的基类视图
@interface TPNavigationBaseVC : TPBaseVC
/// 导航视图
@property (nonatomic, strong) TPNavigationView *navigationView;
/// 是否展示返回
- (BOOL)showBack;
/// 布局子视图
- (void)setupSubviews;
/// 添加约束
- (void)makeConstraints;
@end

NS_ASSUME_NONNULL_END
