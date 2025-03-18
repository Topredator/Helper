//
//  TPCommonPromptBox.h
//  Helper
//
//  Created by Topredator on 2025/3/16.
//
#import <UIKit/UIKit.h>


#import "TPBaseView.h"
NS_ASSUME_NONNULL_BEGIN

/// 协议提示框
@interface TPAgreenebtPromptView : UIView
@property (nonatomic, assign) CGFloat topOffset;
@property (nonatomic, copy) dispatch_block_t callback;
+ (instancetype)view;
- (void)configTitle:(NSString *)title content:(NSString *)content;
- (void)show;
- (void)showIn:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
