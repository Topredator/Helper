//
//  TPNavigationView.h
//  Helper
//
//  Created by Topredator on 2024/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 自定义基类导航视图
@interface TPNavigationView : UIView
/// 标题
@property (nonatomic, copy) NSString *title;
/// 属性标题
@property (nonatomic, strong) NSAttributedString *attributeTitle;
///  是否背景展示线条
@property (nonatomic, assign) BOOL showLines;
/// 返回回调
@property (nonatomic, copy) dispatch_block_t backAction;
+ (instancetype)normalView;
+ (instancetype)backView;
@end

NS_ASSUME_NONNULL_END
