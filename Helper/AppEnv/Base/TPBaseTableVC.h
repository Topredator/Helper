//
//  TPBaseTableVC.h
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import <TPUIKit/TPUIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 基类列表控制器
@interface TPBaseTableVC : TPUIBaseViewController
@property (nonatomic, strong) UITableView *tableview;

/// 创建 tableview
- (void)setupTableView;

/// 更新列表
/// @param datas 数据
- (void)reloadData:(NSArray <TPTableSection <TPTableRow *> *> *)datas;
@end

NS_ASSUME_NONNULL_END
