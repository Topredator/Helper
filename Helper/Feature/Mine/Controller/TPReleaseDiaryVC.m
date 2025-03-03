//
//  TPReleaseDiaryVC.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPReleaseDiaryVC.h"
#import "TPDiaryModule.h"
#import "TPDiaryModel.h"

@interface TPReleaseDiaryVC () <UITextViewDelegate>
@property (nonatomic, strong) UIScrollView *bgScroll;
@property (nonatomic, strong) TPLimitTextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) NSString *content;
/// 发布按钮
@property (nonatomic, strong) UIButton *publicBtn;
@end

@implementation TPReleaseDiaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"日记发布";
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.bgScroll];
    [self.bgScroll addSubview:self.textField];
    [self.bgScroll addSubview:self.textView];
    [self.bgScroll addSubview:self.publicBtn];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.bgScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.navigationView.mas_bottom);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(TPUI.tp_screenWidth - 60, 50));
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(30);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(TPUI.tp_screenWidth - 60, 200));
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.textField.mas_bottom).offset(40);
    }];
    [self.publicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(TPUI.tp_screenWidth - 60, 50));
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.textView.mas_bottom).offset(100);
    }];
}
#pragma mark----------------- UITextViewDelegate -----------------
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    NSInteger count = textView.text.length;
    if (count >= 1000) {
        NSString *text = [textView.text substringToIndex:1000];
        textView.text = text;
    }
    self.content = [textView.text tp_removeWhitespace];
}
- (void)publicBtnAction {
    NSString *title = [self.textField.text tp_removeWhitespace];
    if (title.length <= 0) {
        [self.view tp_toast:@"请填写正确的标题"];
        return;
    }
    if (self.content.length <= 0) {
        [self.view tp_toast:@"内容不能为空"];
        return;
    }
    TPDiaryModel *model = [TPDiaryModel modelWithTitle:title content:self.content];
    
    [TPDBRouter sendTaskMessage:TPDiaryModulePublic argument:[model tp_modelToJSONObject]];
}

- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPDiaryModulePublic) {
        [self.navigationController popViewControllerAnimated:YES];
        [TPAppDelegate().window tp_toast:@"发布成功" duration:1.5];
    }
    return NO;
}

#pragma mark----------------- Getter -----------------
- (UIScrollView *)bgScroll {
    if (!_bgScroll) {
        _bgScroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _bgScroll.showsVerticalScrollIndicator = NO;
    }
    return _bgScroll;
}
- (TPLimitTextField *)textField {
    if (!_textField) {
        _textField = [[TPLimitTextField alloc] initWithFrame:CGRectZero];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.font = [TPUI tp_font:20 weight:FontSemibold];
        _textField.textColor = TPHelperDarkTextColor;
        _textField.placeholder = @"请输入标题";
        _textField.shouldReturnKeyboard = YES;
        _textField.textLimit = 15;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.layer.cornerRadius = 5;
        _textField.layer.borderColor = TPHelperLightDarkTextColor.CGColor;
        _textField.layer.borderWidth = 0.7;
        _textField.layer.masksToBounds = YES;
    }
    return _textField;
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.font = [TPUI tp_font:20 weight:FontMedium];
        _textView.textColor = TPHelperDarkGrayTextColor;
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _textView.tp_placeHolder = @"请填写内容";
        _textView.tp_placeHolderFont = [TPUI tp_font:20 weight:FontMedium];
        _textView.tp_placeHolderColor = TPHelperLightDarkTextColor;
        _textView.layer.cornerRadius = 5;
        _textView.layer.borderColor = TPHelperLightDarkTextColor.CGColor;
        _textView.layer.borderWidth = 0.7;
        _textView.layer.masksToBounds = YES;
        _textView.delegate = self;
        _textView.backgroundColor = TPHelperDefaultBgColor;
    }
    return _textView;
}
- (UIButton *)publicBtn {
    if (!_publicBtn) {
        _publicBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_publicBtn setTitle:@"发   布" forState:UIControlStateNormal];
        [_publicBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_publicBtn addTarget:self action:@selector(publicBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _publicBtn.titleLabel.font = [TPUI tp_font:25 weight:FontMedium];
        _publicBtn.backgroundColor = TPHelperThemeColor;
        _publicBtn.layer.cornerRadius = 5;
        _publicBtn.layer.maskedCorners = YES;
    }
    return _publicBtn;
}
@end
