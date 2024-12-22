//
//  TPBaseCollectionSectionView.m
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import "TPBaseCollectionSectionView.h"

@implementation TPBaseCollectionSectionView
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
