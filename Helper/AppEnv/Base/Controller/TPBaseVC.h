//
//  TPBaseVC.h
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import <TPUIKit/TPUIKit.h>
#import <TPDatabase/TPDatabase.h>
NS_ASSUME_NONNULL_BEGIN

/// 基类 视图控制器
@interface TPBaseVC : TPUIBaseViewController <TPDatabaseMessageHandler>
/// 布局子视图
- (void)setupSubviews;
/// 添加约束
- (void)makeConstraints;
@end

NS_ASSUME_NONNULL_END
