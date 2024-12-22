//
//  TPBaseTableSectionView.h
//  Helper
//
//  Created by Topredator on 2024/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// tableview 分区基类视图
@interface TPBaseTableSectionView : UITableViewHeaderFooterView
/// 构建子视图
- (void)setupSubviews;
/// 添加约束
- (void)makeConstraints;
@end

NS_ASSUME_NONNULL_END
