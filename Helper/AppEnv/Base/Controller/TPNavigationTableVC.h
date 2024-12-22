//
//  TPNavigationTableVC.h
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPBaseVC.h"
#import "TPNavigationView.h"
NS_ASSUME_NONNULL_BEGIN

/// 带有 导航栏的列表 控制器
@interface TPNavigationTableVC : TPBaseVC
@property (nonatomic, strong) UITableView *tableview;
/// 导航视图
@property (nonatomic, strong) TPNavigationView *navigationView;
/// 是否展示返回
- (BOOL)showBack;

/// 更新列表
/// @param datas 数据
- (void)reloadData:(NSArray <TPTableSection <TPTableRow *> *> *)datas;
@end

NS_ASSUME_NONNULL_END
