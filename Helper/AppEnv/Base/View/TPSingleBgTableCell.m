//
//  TPSingleBgTableCell.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPSingleBgTableCell.h"

@implementation TPSingleBgTableCell

- (void)setupSubviews {
    self.contentView.backgroundColor = UIColor.clearColor;
    self.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.container];
}
- (void)makeConstraints {
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(7.5, 15, 7.5, 15));
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(-15);
//        make.top.mas_equalTo(15);
//        make.bottom.mas_equalTo(-15);
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark----------------- Getter -----------------
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectZero];
        _container.layer.cornerRadius = 10;
        _container.layer.masksToBounds = YES;
    }
    return _container;
}

@end
