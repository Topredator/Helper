//
//  TPLineView.h
//  Helper
//
//  Created by Topredator on 2024/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPLineView : UIView
/// 线条宽度
@property (nonatomic, assign) CGFloat lineWidth;
/// 线条间隔
@property (nonatomic, assign) CGFloat lineGap;
/// 线条颜色
@property (nonatomic, strong) UIColor *lineColor;
/// 线条旋转度数
@property (nonatomic, assign) CGFloat rotate;

- (void)buildView;
+ (instancetype)createWithLineWidth:(CGFloat)lineWidth lineGap:(CGFloat)lineGap lineColor:(UIColor *)lineColor rotate:(CGFloat)rotate;
+ (instancetype)createWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth lineGap:(CGFloat)lineGap lineColor:(UIColor *)lineColor rotate:(CGFloat)rotate;
@end

NS_ASSUME_NONNULL_END
