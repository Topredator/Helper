//
//  TPBackgroundCell.h
//  Helper
//
//  Created by Topredator on 2024/12/20.
//

#import <TPUIKit/TPUIKit.h>


/// 背景圆角的cell
@interface TPBackgroundCell : TPUIBaseTableViewCell
@property (nonatomic, strong) UIImageView *imageBackgroundView;
/// 除去了阴影与圆角相关边距的容器视图
@property (nonatomic, strong) UIView *container;

//特殊cell上中下
- (void)prepareCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
