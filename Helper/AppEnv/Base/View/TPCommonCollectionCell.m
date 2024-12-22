//
//  TPCommonCollectionCell.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPCommonCollectionCell.h"

@implementation TPCommonCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TPHelperDefaultBgColor;
        [self setupSubviews];
        [self makeConstraints];
    }
    return self;
}
- (void)setupSubviews {}
- (void)makeConstraints {}
@end
