//
//  UIView+TPUIToast.h
//  Helper
//
//  Created by Topredator on 2024/10/17.
//

#import <UIKit/UIKit.h>

/// toast 扩展
@interface UIView (TPUIToast)
/// 展示加载
- (TPUIToast *)tp_showLoading;
/// 隐藏加载
- (void)tp_hideLoading;


/// 展示toast提示文案
/// - Parameter string: 文案
- (TPUIToast *)tp_toast:(NSString *)string;

/// 展示toast 提示文案
/// - Parameters:
///   - string: 文案
///   - duration: 展示时长
- (TPUIToast *)tp_toast:(NSString *)string duration:(NSTimeInterval)duration;
@end

