//
//  TPBackgroundCell.m
//  Helper
//
//  Created by Topredator on 2024/12/20.
//

#import "TPBackgroundCell.h"

@implementation TPBackgroundCell
- (void)setupSubviews {
    self.contentView.backgroundColor = UIColor.clearColor;
    self.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.imageBackgroundView];
    [self.contentView addSubview:self.container];
    self.imageBackgroundView.image = [self imageWithName:@"Rectangle" insets:UIEdgeInsetsMake(25, 35, 25, 35)];
}
- (void)makeConstraints {
    [self.imageBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, -15, 0));
    }];
}

- (void)prepareCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowCount = [tableView numberOfRowsInSection:indexPath.section];
    if (rowCount == 1) {
        self.imageBackgroundView.image = [self imageWithName:@"Rectangle" insets:UIEdgeInsetsMake(25, 35, 25, 35)];
        [self.imageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, -15, 0));
        }];
        [_container mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 15, 5, 15));

        }];
    } else {
        if (indexPath.row == 0) {
            self.imageBackgroundView.image = [self imageWithName:@"Rectangle1" insets:UIEdgeInsetsMake(17, 35, 0, 35)];
            [self.imageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            [_container mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 15, 0, 15));
            }];
        } else if (indexPath.row == rowCount - 1) {
            self.imageBackgroundView.image = [self imageWithName:@"Rectangle3" insets:UIEdgeInsetsMake(0, 35, 28, 35)];
            [self.imageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, -15, 0));
            }];
            [_container mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 15, 5, 15));
                
            }];
        } else {
            self.imageBackgroundView.image = [self imageWithName:@"Rectangle2" insets:UIEdgeInsetsMake(0, 35, 0, 35)];
            [self.imageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            [_container mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
                
            }];
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImage *)imageWithName:(NSString *)imgName insets:(UIEdgeInsets)insets {
    UIImage *image = [UIImage imageNamed:imgName];
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return image;
}
#pragma mark----------------- Getter -----------------
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _container;
}
- (UIImageView *)imageBackgroundView {
    if (!_imageBackgroundView) {
        _imageBackgroundView = [[UIImageView alloc] initWithImage:[self imageWithName:@"Rectangle" insets:UIEdgeInsetsMake(25, 35, 25, 35)]];
    }
    return _imageBackgroundView;
}
@end
