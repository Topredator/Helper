//
//  TPpublishSingleDetailImageRow.m
//  Helper
//
//  Created by Topredator on 2025/2/24.
//

#import "TPCommonSquareImageRow.h"
#import "TPImagePickerVC.h"

@interface TPCommonSquareImageCell ()
@property (nonatomic, strong) TPUISimButton *addBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIImageView *bgImage;
@end

@implementation TPCommonSquareImageCell

- (void)setupSubviews {
    [self.contentView addSubview:self.bgImage];
    [self.contentView addSubview:self.addBtn];
    [self.contentView addSubview:self.closeBtn];
}
- (void)makeConstraints {
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerY.centerX.mas_equalTo(0);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(20);
    }];
}
- (void)configWithImageName:(NSString *)imageName {
    if (!imageName) {
        self.bgImage.hidden = self.closeBtn.hidden = YES;
        self.bgImage.image = nil;
        self.addBtn.hidden = NO;
    } else {
        self.bgImage.hidden = self.closeBtn.hidden = NO;
        self.bgImage.image = [UIImage imageNamed:imageName];
        self.addBtn.hidden = YES;
    }
}
#pragma mark ==================  Getter   ==================
- (TPUISimButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[TPUISimButton alloc] initWithFrame:CGRectZero];
        _addBtn.iconPosition = TPUISimButtonIconPositionTop;
        _addBtn.iconTextMargin = 5;
        [_addBtn setImage:[UIImage imageNamed:@"publish_add"] forState:UIControlStateNormal];
        [_addBtn setTitle:@"添加图片" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [TPUI tp_font:16 weight:FontMedium];
        [_addBtn setTitleColor:[TPUI tp_t:204] forState:UIControlStateNormal];
        _addBtn.layer.cornerRadius = 8;
        _addBtn.layer.borderWidth = 1;
        _addBtn.layer.borderColor = [TPUI tp_t:204].CGColor;
        _addBtn.layer.masksToBounds = YES;
    }
    return _addBtn;
}
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_closeBtn setImage:[UIImage imageNamed:@"publish_close"] forState:UIControlStateNormal];
    }
    return _closeBtn;
}
- (UIImageView *)bgImage {
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImage.contentMode = UIViewContentModeScaleAspectFill;
        _bgImage.layer.cornerRadius = 8;
        _bgImage.layer.masksToBounds = YES;
    }
    return _bgImage;
}

@end

@implementation TPCommonSquareImageRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPCommonSquareImageCell.class];
    }
    return self;
}
+ (instancetype)row {
    TPCommonSquareImageRow *row = [TPCommonSquareImageRow rowWithID:kTPPublishSingleDetailImageRowKey];
    return row;
}
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    if (self.cell) {
        [self.cell configWithImageName:imageName];
    }
}
- (void)tp_tableViewPreparedCell:(TPCommonSquareImageCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configWithImageName:self.imageName];
    @weakify(self);
    [[cell.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        TPImagePickerVC *pickerVC = [TPImagePickerVC new];
        pickerVC.total = 25;
        pickerVC.column = 3;
        pickerVC.namePrefix = @"home_diary_";
        pickerVC.singleBlock = ^(NSString * _Nonnull imageName) {
            @strongify(self);
            self.imageName = imageName;
        };
        [TPUINavigator pushViewController:pickerVC animated:YES];
    }];
    [[cell.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.imageName = nil;
    }];
    [super tp_tableViewPreparedCell:cell proxy:proxy indexPath:indexPath];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return TPUI.tp_screenWidth - 20;
}
@end
