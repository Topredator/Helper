//
//  TPPersonalDetailVC.m
//  Helper
//
//  Created by Topredator on 2025/3/11.
//

#import "TPPersonalDetailVC.h"

@interface TPPersonalDetailVC ()
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) TPLimitTextField *textField;
@property (nonatomic, strong) UILabel *numberLabel;
@end

@implementation TPPersonalDetailVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maxText = 15;
        self.keyboardType = UIKeyboardTypeDefault;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationView.title = self.navigationTitle;
    self.textField.textLimit = self.maxText;
    self.textField.keyboardType = self.keyboardType;
    self.textField.text = self.content;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.content.length, self.maxText];
    @weakify(self);
    [self.textField setTextDidChangedBlock:^(TPLimitTextField *textField) {
        @strongify(self);
        self.numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", textField.text.length, self.maxText];
    }];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.navigationView addSubview:self.saveBtn];
    [self.view addSubview:self.container];
    [self.container addSubview:self.textField];
    [self.container addSubview:self.numberLabel];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-2);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom).offset(30);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(40);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 10, 5, 110));
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(95, 30));
    }];
}
- (void)saveBtnAction {
    if (!self.textField.text.tp_removeWhitespace.length) {
        [self.view tp_toast:@"请填写正确的内容" duration:1.5];
        return;
    };
    if (self.callback) self.callback(self.textField.text.tp_removeWhitespace);
    [TPUINavigator popViewControllerWithTimes:1 animated:YES];
}
#pragma mark ==================  Getter   ==================
- (UIButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [TPUI tp_font:18 weight:FontMedium];
        [_saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectZero];
        _container.backgroundColor = TPHelperDefaultBgColor;
        _container.layer.cornerRadius = 8;
        _container.layer.maskedCorners = YES;
    }
    return _container;
}
- (TPLimitTextField *)textField {
    if (!_textField) {
        _textField = [[TPLimitTextField alloc] initWithFrame:CGRectZero];
        _textField.font = [TPUI tp_font:18 weight:FontRegular];
        _textField.textColor = TPHelperDarkGrayTextColor;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.shouldReturnKeyboard = YES;
        _textField.textLimit = 30;
    }
    return _textField;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.textColor = [TPUI tp_t:204];
        _numberLabel.textAlignment = NSTextAlignmentRight;
        _numberLabel.font = [TPUI tp_font:16 weight:FontMedium];
    }
    return _numberLabel;
}
@end
