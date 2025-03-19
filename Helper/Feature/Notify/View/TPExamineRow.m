//
//  TPExamineRow.m
//  Helper
//
//  Created by Topredator on 2025/3/18.
//

#import "TPExamineRow.h"

@interface TPExamineCell ()
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) TPTextDisplayView *dispalyView;
@property (nonatomic, strong) UIButton *permissionBtn;
@property (nonatomic, strong) UIButton *refuseBtn;
@property (nonatomic, strong) UILabel *refuseLabel;
@end

@implementation TPExamineCell
- (void)setupSubviews {
    self.contentView.backgroundColor = TPHelperDefaultBgColor;
    [self.contentView addSubview:self.container];
    [self.container addSubview:self.dispalyView];
    [self.container addSubview:self.logoImage];
    [self.container addSubview:self.permissionBtn];
    [self.container addSubview:self.refuseBtn];
    [self.container addSubview:self.refuseLabel];
}
- (void)makeConstraints {
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 20, 10, 20));
    }];
    [self.dispalyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-65);
        make.top.mas_equalTo(20);
    }];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self.dispalyView.mas_centerY).offset(0);
        make.right.mas_equalTo(-10);
    }];
    [self.refuseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(40);
    }];
    [self.permissionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.width.equalTo(self.refuseBtn.mas_width);
        make.left.equalTo(self.refuseBtn.mas_right).offset(20);
    }];
    
    
    [self.refuseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
}
- (void)configWithModel:(TPApplyModel *)model {
    NSString *content = [NSString stringWithFormat:@"<at value='%@'>%@</at> 申请领养 ${ 我 } 的宠物 <subject value='%@'>%@</subject>", model.applicant.userId, model.applicant.name, model.animal.animalId, model.animal.name];
    self.dispalyView.text = content;
    self.refuseLabel.hidden = model.applyStatus != TPApplyStatusBeRejected;
    self.refuseLabel.text = [NSString stringWithFormat:@"已被我拒绝: %@", model.refusalReason];
    self.refuseBtn.hidden = model.applyStatus != TPApplyStatusApplying;
    self.permissionBtn.hidden = model.applyStatus != TPApplyStatusApplying;
    
    NSString *imageName = @"apply_appling";
    switch (model.applyStatus) {
        case TPApplyStatusBeRejected: imageName = @"apply_declined"; break;
        case TPApplyStatusSuccess: imageName = @"apply_success"; break;
        default: break;
    }
    self.logoImage.image = [UIImage imageNamed:imageName];
    
    switch (model.applyStatus) {
        case TPApplyStatusApplying: { // 申请中
            [self.dispalyView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-65);
                make.top.mas_equalTo(20);
                make.bottom.equalTo(self.refuseBtn.mas_top).offset(-10);
                make.height.mas_equalTo([TPTextDisplayView getHeightWithText:content rectSize:CGSizeMake(TPUI.tp_screenWidth - 40 - 20, CGFLOAT_MAX) labelConfig:[TPRichTextLabelConfig new]]);
            }];
            
        }
            break;
        case TPApplyStatusBeRejected: { // 拒绝
            [self.dispalyView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-65);
                make.top.mas_equalTo(20);
                make.bottom.equalTo(self.refuseLabel.mas_top).offset(-10);
                make.height.mas_equalTo([TPTextDisplayView getHeightWithText:content rectSize:CGSizeMake(TPUI.tp_screenWidth - 40 - 20, CGFLOAT_MAX) labelConfig:[TPRichTextLabelConfig new]]);
            }];
        }
            break;
        default: { // 成功
            [self.dispalyView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-65);
                make.top.mas_equalTo(20);
                make.bottom.mas_equalTo(-20);
                make.height.mas_equalTo([TPTextDisplayView getHeightWithText:content rectSize:CGSizeMake(TPUI.tp_screenWidth - 40 - 20, CGFLOAT_MAX) labelConfig:[TPRichTextLabelConfig new]]);
            }];
        }
            break;
    }
}
#pragma mark ==================  Getter   ==================
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectZero];
        _container.layer.cornerRadius = 10;
        _container.layer.masksToBounds = YES;
        _container.backgroundColor = UIColor.whiteColor;
    }
    return _container;
}
- (UIImageView *)logoImage {
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _logoImage;
}
- (TPTextDisplayView *)dispalyView {
    if (!_dispalyView) {
        _dispalyView = [[TPTextDisplayView alloc] initWithFrame:CGRectZero];
        _dispalyView.backgroundColor = UIColor.clearColor;
    }
    return _dispalyView;
}
- (UIButton *)refuseBtn {
    if (!_refuseBtn) {
        _refuseBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        [_refuseBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        _refuseBtn.titleLabel.font = [TPUI tp_font:17 weight:FontMedium];
    }
    return _refuseBtn;
}
- (UIButton *)permissionBtn {
    if (!_permissionBtn) {
        _permissionBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_permissionBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_permissionBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        _permissionBtn.titleLabel.font = [TPUI tp_font:17 weight:FontMedium];
    }
    return _permissionBtn;
}
- (UILabel *)refuseLabel {
    if (!_refuseLabel) {
        _refuseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _refuseLabel.textColor = UIColor.redColor;
        _refuseLabel.numberOfLines = 0;
        _refuseLabel.font = [TPUI tp_font:16 weight:FontMedium];
        _refuseLabel.hidden = YES;
    }
    return _refuseLabel;
}
@end

@interface TPExamineRow ()
@property (nonatomic, strong) TPApplyModel *model;
@end

@implementation TPExamineRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPExamineCell.class];
    }
    return self;
}
+ (instancetype)rowWithModel:(TPApplyModel *)model {
    TPExamineRow *row = [TPExamineRow row];
    row.model = model;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPExamineCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configWithModel:self.model];
    [cell.refuseBtn addTarget:self action:@selector(refuseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.permissionBtn addTarget:self action:@selector(permissionBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)refuseBtnAction {
    @weakify(self);
    // 创建 UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"拒绝领养申请"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入拒绝原因";
    }];
    
    // 创建确认动作
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        // 获取输入框中的文本
        UITextField *inputTextField = alertController.textFields.firstObject;
        NSString *inputText = inputTextField.text.tp_removeWhitespace;
        if (!inputText.length) {
            [TPUINavigator.currentViewController.view tp_toast:@"拒绝原因不能为空"];
            return;
        }
        @strongify(self);
        self.model.applyStatus = TPApplyStatusBeRejected;
        self.model.refusalReason = inputText;
        self.model.endTime = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
        [TPDBRouter sendTaskMessage:TPUserRejectedApplication argument:[self.model tp_modelToJSONObject]];
    }];
    
    // 创建取消动作
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    // 将动作添加到 UIAlertController
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    
    // 显示 UIAlertController
    [TPUINavigator.currentViewController presentViewController:alertController animated:YES completion:nil];
}
- (void)permissionBtnAction {
    @weakify(self);
    [TPUIAlert alertShow:^(TPUIAlertMaker *make) {
        make.title(@"确定同意领养吗？");
        make.cancleOption(@"取消");
        make.addOption(TPUIAlertColorOption(@"同意", ^{
            @strongify(self);
            self.model.applyStatus = TPApplyStatusSuccess;
            self.model.endTime = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
            [TPDBRouter sendTaskMessage:TPUserAgreedToApplication argument:[self.model tp_modelToJSONObject]];
        }, TPHelperThemeColor));
    }];
}
@end
