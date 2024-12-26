//
//  TPAdoptDetailVC.h
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPNavigationTableVC.h"
#import "TPAdoptModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 领养详情
@interface TPAdoptDetailVC : TPNavigationTableVC
@property (nonatomic, strong) TPAdoptModel *adoptModel;
@end

NS_ASSUME_NONNULL_END
