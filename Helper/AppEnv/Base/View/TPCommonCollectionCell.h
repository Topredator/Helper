//
//  TPCommonCollectionCell.h
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 通用collectionViewCell
@interface TPCommonCollectionCell : UICollectionViewCell
/// 构建子视图
- (void)setupSubviews;
/// 添加约束
- (void)makeConstraints;
@end

NS_ASSUME_NONNULL_END
