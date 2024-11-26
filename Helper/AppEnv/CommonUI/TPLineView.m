//
//  TPLineView.m
//  Helper
//
//  Created by Topredator on 2024/10/12.
//

#import "TPLineView.h"


@interface TPLineView ()
@property (nonatomic, strong) UIView *containerView;
@end

@implementation TPLineView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.rotate = 45.0;
    }
    return self;
}
+ (instancetype)createWithLineWidth:(CGFloat)lineWidth lineGap:(CGFloat)lineGap lineColor:(UIColor *)lineColor rotate:(CGFloat)rotate {
    return [self createWithFrame:CGRectZero lineWidth:lineWidth lineGap:lineGap lineColor:lineColor rotate:rotate];
}
+ (instancetype)createWithFrame:(CGRect)frame 
                      lineWidth:(CGFloat)lineWidth
                        lineGap:(CGFloat)lineGap
                      lineColor:(UIColor *)lineColor
                         rotate:(CGFloat)rotate {
    TPLineView *lineView = [[self alloc] initWithFrame:frame];
    lineView.lineWidth = lineWidth;
    lineView.lineGap = lineGap;
    lineView.lineColor = lineColor;
    lineView.rotate = rotate;
    return lineView;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self buildView];
}
- (void)buildView {
    if (self.lineWidth <= 0 && self.lineGap <= 0) {
        return;
    }
    [self.containerView removeFromSuperview];
    // 获取长度
    CGFloat width  = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat containerViewWidth = (width + height) * 0.75;
    
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerViewWidth, containerViewWidth)];
    self.containerView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    NSInteger lineCount = containerViewWidth / (self.lineWidth + self.lineGap);
    for (NSInteger count = 0; count < lineCount + 1; count ++) {
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(count * (self.lineWidth + self.lineGap), 0, self.lineWidth, containerViewWidth)];
        tempView.backgroundColor = self.lineColor ?: UIColor.blackColor;
        [self.containerView addSubview:tempView];
    }
    
    self.containerView.transform = CGAffineTransformRotate(self.containerView.transform, [self convertedToRadiansWithDegrees:self.rotate]);
    [self addSubview:self.containerView];
}

- (CGFloat)convertedToRadiansWithDegrees:(CGFloat)degrees {
    return (M_PI * degrees) / 180.f;
}
@end
