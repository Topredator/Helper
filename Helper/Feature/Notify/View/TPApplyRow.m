//
//  TPApplyRow.m
//  Helper
//
//  Created by Topredator on 2024/12/28.
//

#import "TPApplyRow.h"

@interface TPApplyCell : TPUIBaseTableViewCell
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) TPTextDisplayView *dispalyView;
@property (nonatomic, strong) UILabel *refuseLabel;
@end
@implementation TPApplyCell
- (void)setupSubviews {
    self.contentView.backgroundColor = TPHelperDefaultBgColor;
    [self.contentView addSubview:self.container];
    [self.container addSubview:self.logoImage];
    [self.container addSubview:self.dispalyView];
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
//        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 10, 20, 65));
    }];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self.dispalyView.mas_centerY).offset(0);
        make.right.mas_equalTo(-10);
    }];
    
    [self.refuseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-20);
    }];
}
- (void)configWithModel:(TPApplyModel *)model {
    NSString *content = [NSString stringWithFormat:@"${ 我 } 申请领养 <at value='%@'>%@</at> 的宠物 <subject value='%@'>%@</subject>", model.respondent.userId, model.respondent.name, model.animal.animalId, model.animal.name];
    self.dispalyView.text = content;
    self.refuseLabel.hidden = model.applyStatus != TPApplyStatusBeRejected;
    self.refuseLabel.text = [NSString stringWithFormat:@"拒绝原因: %@", model.refusalReason];
    if (model.applyStatus != TPApplyStatusBeRejected) {
        [self.dispalyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-65);
            make.top.mas_equalTo(20);
            make.bottom.mas_equalTo(-20);
            make.height.mas_equalTo([TPTextDisplayView getHeightWithText:content rectSize:CGSizeMake(TPUI.tp_screenWidth - 40 - 20, CGFLOAT_MAX) labelConfig:[TPRichTextLabelConfig new]]);
        }];
        [self.refuseLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-20);
        }];
    } else {
        [self.dispalyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-65);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo([TPTextDisplayView getHeightWithText:content rectSize:CGSizeMake(TPUI.tp_screenWidth - 40 - 20, CGFLOAT_MAX) labelConfig:[TPRichTextLabelConfig new]]);
        }];
        [self.refuseLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-20);
            make.top.equalTo(self.dispalyView.mas_bottom).offset(10);
        }];
    }
    NSString *imageName = @"apply_appling";
    switch (model.applyStatus) {
        case TPApplyStatusBeRejected: imageName = @"apply_declined"; break;
        case TPApplyStatusSuccess: imageName = @"apply_success"; break;
        default: break;
    }
    self.logoImage.image = [UIImage imageNamed:imageName];
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

@interface TPApplyRow () <TPTextDisplayViewDelegate>
@property (nonatomic, strong) TPApplyModel *model;
@property (nonatomic, assign) BOOL isApply;
@end

@implementation TPApplyRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPApplyCell.class];
    }
    return self;
}
+ (instancetype)rowWithModel:(TPApplyModel *)model {
    TPApplyRow *row = [TPApplyRow row];
    row.model = model;
    return row;
}
+ (instancetype)applyRowWithModel:(TPApplyModel *)model {
    TPApplyRow *row = [TPApplyRow row];
    row.model = model;
    return row;
}
+ (instancetype)examineRowWithModel:(TPApplyModel *)model {
    TPApplyRow *row = [TPApplyRow row];
    row.model = model;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPApplyCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.dispalyView.delegate = self;
    [cell configWithModel:self.model];
}
- (BOOL)tp_tableViewCanEditRowWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return self.model.applyStatus == TPApplyStatusApplying;
}
- (NSString *)tp_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPath:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return @"取消";
}
- (void)tp_tableViewCommitEditingStyle:(UITableViewCellEditingStyle)editingStyle proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    // 取消申请
    [TPUIAlert alertShow:^(TPUIAlertMaker *make) {
        make.title(@"确认").message(@"您确定要取消领养申请吗?");
        make.addOption(TPUIAlertBlockOption(@"确定", ^{
            @strongify(self);
            [TPDBRouter sendTaskMessage:TPUserCancelApplication argument:self.model.applyId];
        }));
        make.cancleOption(@"取消");
    }];
}
- (void)tp_textDisplayView:(TPTextDisplayView *)displayView labelType:(TPRichTextLabelType)labelType content:(NSString *)content {
    if (labelType == TPRichTextLabelTypeUser) {
        
    } else if (labelType == TPRichTextLabelTypeKey) {
        
    }
}
@end
