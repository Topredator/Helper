//
//  TPSingleBgTableCell.h
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import <TPUIKit/TPUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPSingleBgTableCell : TPUIBaseTableViewCell
/// 除去了阴影与圆角相关边距的容器视图
@property (nonatomic, strong) UIView *container;
@end

NS_ASSUME_NONNULL_END
