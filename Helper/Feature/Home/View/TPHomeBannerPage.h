//
//  TPHomeBannerPage.h
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import <TPUIKit/TPUIKit.h>
#import "TPHomeBannerModel.h"


NS_ASSUME_NONNULL_BEGIN

/// 首页 banner页
@interface TPHomeBannerPage : TPUIBannerPageView
- (void)configWithModel:(TPHomeBannerModel *)model;
@end

NS_ASSUME_NONNULL_END
