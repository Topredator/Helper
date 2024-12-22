//
//  TPHomeBannerSection.h
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import <TPFoundation/TPFoundation.h>
#import "TPHomeBannerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPHomeBannerSection : TPCollectionSection
+ (instancetype)sectionWithBanners:(NSArray <TPHomeBannerModel *>*)banners;
@end

NS_ASSUME_NONNULL_END
