//
//  TPPublishMultipleImagesRow.m
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import "TPCommonMultipleImagesRow.h"
#import "TPImagePickerVC.h"

typedef void(^TPCommonMutipleEditBlock)(NSArray *images);

@interface TPCommonMultipleImagesCell ()
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, copy) TPCommonMutipleEditBlock editBlock;
@end

@implementation TPCommonMultipleImagesCell
- (void)setupSubviews {
    [self.contentView addSubview:self.container];
}
- (void)makeConstraints {
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}
- (void)configImages:(NSArray *)images {
    [self.images removeAllObjects];
    [self.images addObjectsFromArray:images];
    [self updateContainer];
}
- (void)updateContainer {
    [self.container tp_removeAllSubviews];
    CGFloat width = (TPUI.tp_screenWidth - 40) / 3;
    NSInteger left = 0, top = 0;
    for (NSInteger i = 0; i < self.images.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:self.images[i]];
        imageView.layer.cornerRadius = 6;
        imageView.layer.borderWidth = 1;
        imageView.layer.borderColor = [TPUI tp_t:204].CGColor;
        imageView.layer.masksToBounds = YES;
        [self.container addSubview:imageView];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [closeBtn setImage:[UIImage imageNamed:@"publish_close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        closeBtn.tag = 1000 + i;
        [imageView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
        }];
        left = (i % 3) * (width + 10);
        top = (i / 3) * (width + 10);
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.top.mas_equalTo(top);
            make.size.mas_equalTo(CGSizeMake(width, width));
        }];
    }
    NSInteger count = self.images.count;
    if (count < 9) {
        if (count == 0) {
            left = 0;
            top = 0.0;
        } else {
            left = (count % 3) * (width + 10);
            top = (count / 3) * (width + 10);
        }
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [addBtn setImage:[UIImage imageNamed:@"publish_add"] forState:UIControlStateNormal];
        addBtn.layer.cornerRadius = 6;
        addBtn.layer.borderWidth = 1;
        addBtn.layer.borderColor = [TPUI tp_t:204].CGColor;
        addBtn.layer.masksToBounds = YES;
        [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.container addSubview:addBtn];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, width));
            make.left.mas_equalTo(left);
            make.top.mas_equalTo(top);
        }];
    }
    if (self.editBlock) self.editBlock(self.images.copy);
}
- (void)addBtnAction {
    TPImagePickerVC *pickerVC = [TPImagePickerVC new];
    pickerVC.total = 25;
    pickerVC.column = 3;
    pickerVC.maxSelected = 9 - self.images.count;
    pickerVC.isMultiple = YES;
    pickerVC.namePrefix = @"home_diary_";
    @weakify(self);
    pickerVC.multipleBlock = ^(NSArray * _Nonnull imageNames) {
        @strongify(self);
        [self.images addObjectsFromArray:imageNames];
        [self updateContainer];
    };
    [TPUINavigator pushViewController:pickerVC animated:YES];
}
- (void)closeBtnAction:(UIButton *)btn {
    NSInteger index = btn.tag - 1000;
    [self.images removeObjectAtIndex:index];
    [self updateContainer];
}
#pragma mark ==================  Getter   ==================
- (NSMutableArray *)images {
    if (!_images) {
        _images = @[].mutableCopy;
    }
    return _images;
}
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectZero];
        _container.layer.cornerRadius = 6;
        _container.layer.masksToBounds = YES;
    }
    return _container;
}
@end

@implementation TPCommonMultipleImagesRow
@dynamic cell;
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPCommonMultipleImagesCell.class];
    }
    return self;
}
- (void)setImages:(NSArray *)images {
    _images = images;
    if (self.cell.images.count != images.count) {
        [self.cell configImages:images];
    }
}
- (void)tp_tableViewPreparedCell:(TPCommonMultipleImagesCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configImages:self.images];
    @weakify(self);
    cell.editBlock = ^(NSArray *images) {
        @strongify(self);
        [proxy.tableView beginUpdates];
        self.images = images;
        [proxy.tableView endUpdates];
    };
    [super tp_tableViewPreparedCell:cell proxy:proxy indexPath:indexPath];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    CGFloat height = (TPUI.tp_screenWidth - 40) / 3;
    if (self.images.count >= 6) {
        return 20 + height * 3 + 10 * 2;
    } else if (self.images.count >= 3 && self.images.count < 6) {
        return 30 + height * 2;
    }
    return 20 + height;
}
@end
