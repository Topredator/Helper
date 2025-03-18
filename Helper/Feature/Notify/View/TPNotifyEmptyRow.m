//
//  TPNotifyEmptyRow.m
//  Helper
//
//  Created by Topredator on 2025/3/17.
//

#import "TPNotifyEmptyRow.h"

@interface TPNotifyEmptyCell : TPUIBaseTableViewCell
@property (nonatomic, strong) UIImageView *logoImage;
@end
@implementation TPNotifyEmptyCell

- (void)setupSubviews {
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.logoImage];
}
- (void)makeConstraints {
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(96, 184));
        make.centerX.centerY.mas_equalTo(0);
    }];
}
#pragma mark ==================  Getter   ==================
- (UIImageView *)logoImage {
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_emptydata"]];
    }
    return _logoImage;
}

@end


@interface TPNotifyEmptyRow ()

@end

@implementation TPNotifyEmptyRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPNotifyEmptyCell.class];
    }
    return self;
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 250;
}
@end
