//
//  TPBaseView.m
//  Helper
//
//  Created by Topredator on 2024/12/19.
//

#import "TPBaseView.h"

@implementation TPBaseView
+ (instancetype)view {
    return [[self alloc] initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        [self makeConstraints];
    }
    return self;
}
- (void)setupSubviews {
}
- (void)makeConstraints {
}

@end
