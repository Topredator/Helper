//
//  TPDonateExpressView.m
//  Helper
//
//  Created by Topredator on 2025/3/24.
//

#import "TPDonateExpressView.h"

@interface TPDonateExpressView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) TPLimitTextField *textField;
@end

@implementation TPDonateExpressView
- (void)setExpressNumber:(NSString *)expressNumber {
    _expressNumber = expressNumber;
    if (![expressNumber isEqualToString:self.textField.text]) {
        self.textField.text = expressNumber;
    }
}
- (void)setupSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.textField];
    @weakify(self);
    self.textField.textDidChangedBlock = ^(TPLimitTextField *textField) {
        @strongify(self);
        self.expressNumber = textField.text;
    };
}
- (void)makeConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(100);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(10);
        make.left.equalTo(self.titleLabel.mas_right).offset(15);
    }];
}
#pragma mark ==================  Getter   ==================
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [TPUI tp_font:18 weight:FontSemibold];
        _titleLabel.textColor = TPHelperDarkTextColor;
        _titleLabel.text = @"快递单号: ";
    }
    return _titleLabel;
}
- (TPLimitTextField *)textField {
    if (!_textField) {
        _textField = [[TPLimitTextField alloc] initWithFrame:CGRectZero];
        _textField.font = [TPUI tp_font:16 weight:FontRegular];
        _textField.textColor = TPHelperLightDarkTextColor;
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.shouldReturnKeyboard = YES;
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = TPHelperLightDarkTextColor.CGColor;
        _textField.layer.cornerRadius = 5;
        _textField.layer.masksToBounds = YES;
        _textField.placeholder = @"请输入快递单号";
        _textField.textLimit = 25;
        _textField.regexpPattern = @"[0-9a-zA-Z]+";
    }
    return _textField;
}

@end
