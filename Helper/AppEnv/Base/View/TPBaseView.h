//
//  TPBaseView.h
//  Helper
//
//  Created by Topredator on 2024/12/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 基类视图
@interface TPBaseView : UIView
+ (instancetype)view;
/// 构建子视图
- (void)setupSubviews;
/// 添加约束
- (void)makeConstraints;
@end

NS_ASSUME_NONNULL_END
