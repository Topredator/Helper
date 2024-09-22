//
//  TPNavigationController.h
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import <TPUIKit/TPUIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 基类导航控制器
@interface TPNavigationController : TPUIBackNavigationController
- (void)configWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;
@end

NS_ASSUME_NONNULL_END
