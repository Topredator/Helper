//
//  TPImagePickerBottomView.m
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import "TPImagePickerBottomView.h"

@implementation TPImagePickerBottomView

- (void)setupSubviews {
    [self addSubview:self.allBtn];
    [self addSubview:self.sureBtn];
}
- (void)makeConstraints {
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(20);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-20);
    }];
}

#pragma mark ==================  Getter   ==================
- (TPUISimButton *)allBtn {
    if (!_allBtn) {
        _allBtn = [[TPUISimButton alloc] initWithFrame:CGRectZero];
        _allBtn.iconPosition = TPUISimButtonIconPositionLeft;
        _allBtn.iconTextMargin = 10;
        [_allBtn setImage:[UIImage imageNamed:@"image_picker_unselected"] forState:UIControlStateNormal];
        [_allBtn setImage:[UIImage imageNamed:@"image_picker_selected"] forState:UIControlStateSelected];
        [_allBtn setTitle:@"全选" forState:UIControlStateNormal];
        _allBtn.titleLabel.font = [TPUI tp_font:15 weight:FontMedium];
        [_allBtn setTitleColor:[TPUI tp_t:138] forState:UIControlStateNormal];
        [_allBtn setTitleColor:[TPUI tp_r:18 g:150 b:219] forState:UIControlStateSelected];
    }
    return _allBtn;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_sureBtn setTitle:@"确定(0)" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [TPUI tp_font:18 weight:FontMedium];
        [_sureBtn setTitleColor:[TPUI tp_t:138] forState:UIControlStateDisabled];
        [_sureBtn setTitleColor:[TPUI tp_r:18 g:150 b:219] forState:UIControlStateNormal];
        _sureBtn.enabled = NO;
    }
    return _sureBtn;
}
@end
