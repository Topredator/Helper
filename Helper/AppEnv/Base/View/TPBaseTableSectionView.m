//
//  TPBaseTableSectionView.m
//  Helper
//
//  Created by Topredator on 2024/12/20.
//

#import "TPBaseTableSectionView.h"

@implementation TPBaseTableSectionView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
