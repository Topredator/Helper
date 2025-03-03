//
//  TPNavigationCollectionVC.m
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import "TPImagePickerVC.h"

#import "TPImagePickerSection.h"
#import "TPImagePickerRow.h"
#import "TPImagePickerBottomView.h"

@interface TPImagePickerVC ()
@property (nonatomic, strong) TPImagePickerSection *section;
@property (nonatomic, copy) NSArray *datas;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, strong) TPImagePickerBottomView *bottomView;
@end

@implementation TPImagePickerVC
- (instancetype)init {
    self = [super init];
    if (self) {
        self.column = 1;
        self.maxSelected = 9;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    self.bottomView.allBtn.hidden = !self.canAllSelected;
}
- (void)setupSubviews {
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.collectionView];
    if (self.isMultiple) {
        [self.view addSubview:self.bottomView];
    }
}
- (void)makeConstraints {
    __weak typeof(self) weakSelf = self;
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(TPUI.tp_topBarHeight);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(weakSelf.navigationView.mas_bottom);
        make.bottom.mas_equalTo(weakSelf.isMultiple ? - 50 - TPUI.tp_bottomSafeAreaHeight : 0);
    }];
    if (self.isMultiple) {
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.collectionView.mas_bottom);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
}
- (void)loadData {
    if (!self.namePrefix.length) {
        [self.view tp_toast:@"请传入图片名称前缀" duration:1.5];
        return;
    }
    if (self.total <= 0) {
        [self.view tp_toast:@"数据不能为空" duration:1.5];
        return;
    }
    
    NSMutableArray *datas = @[].mutableCopy;
    for (NSInteger i = 0; i < self.total; i ++) {
        NSString *name = [self.namePrefix stringByAppendingFormat:@"%ld", i + 1];
        [datas addObject:name];
    }
    self.datas = datas.copy;
    [self reloadData];
}
- (void)reloadData {
    [self.section removeAllObjects];
    for (NSString *imageName in self.datas) {
        [self.section addObject:[self rowWithName:imageName]];
    }
    [self.collectionView.TPProxy reloadData:@[self.section]];
}
- (TPImagePickerRow *)rowWithName:(NSString *)name {
    @weakify(self);
    TPImagePickerRow *row = [TPImagePickerRow rowWithImageName:name];
    row.isMultiple = self.isMultiple;
    row.selected = [self.selectArray containsObject:name];
    row.itemSizeBlock = ^CGSize(__kindof TPCollectionRow * _Nonnull rowData, TPCollectionViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        @strongify(self);
        CGFloat width = (TPUI.tp_screenWidth - 30) / self.column;
        return  self.column == 1 ? CGSizeMake(TPUI.tp_screenWidth - 30, 150) : CGSizeMake(width, width);
    };
    row.didSelectedBlock = ^(TPImagePickerRow * _Nonnull rowData, TPCollectionViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        @strongify(self);
        // 多选
        if (self.isMultiple) {
            if (!self.canAllSelected && !rowData.selected && self.selectArray.count == self.maxSelected) {
                return;
            }
            rowData.selected = !rowData.selected;
            if (rowData.selected) {
                [self.selectArray addObject:rowData.imageName];
            } else {
                [self.selectArray removeObject:rowData.imageName];
            }
            [self.bottomView.sureBtn setTitle:[NSString stringWithFormat:@"确定(%ld)", self.selectArray.count] forState:UIControlStateNormal];
            self.bottomView.allBtn.selected = self.selectArray.count == self.datas.count;
            self.bottomView.sureBtn.enabled = self.selectArray.count > 0;
        } else {
            if (self.singleBlock) {
                self.singleBlock(rowData.imageName);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    };
    return row;
}
- (void)allBtnAction:(TPUISimButton *)btn {
    btn.selected = !btn.selected;
    [self.selectArray removeAllObjects];
    if (btn.selected) {
        [self.selectArray addObjectsFromArray:self.datas];
    }
    [self reloadData];
    self.bottomView.sureBtn.enabled = self.selectArray.count > 0;
}
- (void)sureBtnAction {
    if (!self.selectArray.count) {
        [self.view tp_toast:@"请选择" duration:1.5];
        return;
    }
    if (self.multipleBlock) self.multipleBlock(self.selectArray.copy);
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark----------------- Getter -----------------
- (TPNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [TPNavigationView backView];
        _navigationView.showLines = YES;
        _navigationView.title = @"图片选择";
    }
    return _navigationView;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:UICollectionViewFlowLayout.new];
        _collectionView.TPProxy = [TPCollectionViewProxy proxyWithCollectionView:_collectionView];
        [TPUI tp_adjustsInsets:_collectionView vc:self];
    }
    return _collectionView;
}
- (TPImagePickerSection *)section {
    if (!_section) {
        _section = [TPImagePickerSection section];
    }
    return _section;
}
- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = @[].mutableCopy;
    }
    return _selectArray;
}
- (TPImagePickerBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[TPImagePickerBottomView alloc] initWithFrame:CGRectZero];
        [_bottomView.allBtn addTarget:self action:@selector(allBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}
@end
