//
//  TPBaseCollectionSectionView.h
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPBaseCollectionSectionView : UICollectionReusableView
/// 构建子视图
- (void)setupSubviews;
/// 添加约束
- (void)makeConstraints;
@end

NS_ASSUME_NONNULL_END
