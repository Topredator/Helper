//
//  TPBaseWebVC.h
//  Helper
//
//  Created by Topredator on 2025/2/6.
//

#import "TPNavigationBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

/// 基类浏览器页
@interface TPBaseWebVC : TPNavigationBaseVC
@property (nonatomic, assign) BOOL autoTitle;
@property (nonatomic, assign) BOOL autoProgress;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *url;
- (void)startRequest;
@end

NS_ASSUME_NONNULL_END
