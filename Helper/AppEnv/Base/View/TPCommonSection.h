//
//  TPCommonSection.h
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 通用无header、footer分区
@interface TPCommonSection : TPTableSection
@property (nonatomic, assign) CGFloat h_height;
@property (nonatomic, assign) CGFloat f_height;
@end

NS_ASSUME_NONNULL_END
