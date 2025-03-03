//
//  TPAnimalVC.m
//  Helper
//
//  Created by Topredator on 2025/2/25.
//

#import "TPAnimalVC.h"
#import "TPCommonTitleSection.h"
#import "TPAnimalSwitchRow.h"
#import "TPAnimalAlertRow.h"
#import "TPAnimalInputRow.h"
#import "TPAnimalAvatarRow.h"
#import "TPImagePickerVC.h"

static NSString *kAnimalAvatarRowKey = @"com.helper.animal.row.avatar";
static NSString *kAnimalNameRowKey = @"com.helper.animal.row.name";
static NSString *kAnimalAgeRowKey = @"com.helper.animal.row.age";
static NSString *kAnimalBreedRowKey = @"com.helper.animal.row.breed";
static NSString *kAnimalNumberRowKey = @"com.helper.animal.row.number";
static NSString *kAnimalSterilizationRowKey = @"com.helper.animal.row.sterilization";
static NSString *kAnimalDewormingRowKey = @"com.helper.animal.row.deworming";
static NSString *kAnimalVaccineRowKey = @"com.helper.animal.row.vaccine";
static NSString *kAnimalCategoryRowKey = @"com.helper.animal.row.category";
static NSString *kAnimalGenderRowKey = @"com.helper.animal.row.gender";

@interface TPAnimalVC ()
@property (nonatomic, strong) UIButton *makeSureBtn;
@property (nonatomic, strong) TPAnimalModel *model;
@end

@implementation TPAnimalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"宠物信息";
    [self.makeSureBtn setTitle:self.animalModel ? @"保存" : @"创建" forState:UIControlStateNormal];
    self.model = self.animalModel ? self.animalModel : [TPAnimalModel generateModel];
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.makeSureBtn];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-60 - TPUI.tp_bottomSafeAreaHeight);
    }];
    [self.makeSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(TPUI.tp_screenWidth - 60, 50));
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-5 - TPUI.tp_bottomSafeAreaHeight);
    }];
}
- (void)loadData {
    TPCommonTitleSection *section = [TPCommonTitleSection sectionWithTitle:@"萌宠信息"];
    // 头像
    [section addObject:[self avatarRow]];
    // 类型
    [section addObject:[self categoryRow]];
    // 名称
    [section addObject:[self nameRow]];
    // 年龄
    [section addObject:[self ageRow]];
    // 性别
    [section addObject:[self genderRow]];
    // 品种
    [section addObject:[self breedRow]];
    // 编号
    [section addObject:[self numberRow]];
    // 绝育
    [section addObject:[self sterilizationRow]];
    // 驱虫
    [section addObject:[self dewormingRow]];
    // 疫苗
    [section addObject:[self vaccineRow]];
    [self reloadData:@[section]];
}
- (TPAnimalAvatarRow *)avatarRow {
    TPAnimalAvatarRow *row = [TPAnimalAvatarRow rowWithID:kAnimalAvatarRowKey];
    @weakify(self, row);
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        @strongify(self);
        TPImagePickerVC *pickerVC = [TPImagePickerVC new];
        pickerVC.total = 30;
        pickerVC.namePrefix = self.model.category == TPAnimalCategoryCat ?  @"cat_avatar_" : @"dog_avatar_";
        pickerVC.column = 3;
        pickerVC.singleBlock = ^(NSString * _Nonnull imageName) {
            @strongify(row);
            row.avatar = imageName;
        };
        [TPUINavigator pushViewController:pickerVC animated:YES];
    };
    row.avatar = self.model.thumbImage;
    return row;
}
- (TPAnimalInputRow *)nameRow {
    TPAnimalInputRow *row = [TPAnimalInputRow nameRowWithId:kAnimalNameRowKey];
    row.text = self.model.name;
    return row;
}
- (TPAnimalInputRow *)ageRow {
    TPAnimalInputRow *row = [TPAnimalInputRow ageRowWithId:kAnimalAgeRowKey];
    row.text = [NSString stringWithFormat:@"%ld", self.model.age];
    return row;
}
- (TPAnimalInputRow *)breedRow {
    TPAnimalInputRow *row = [TPAnimalInputRow breedRowWithId:kAnimalBreedRowKey];
    row.text = self.model.breed;
    return row;
}
- (TPAnimalInputRow *)numberRow {
    TPAnimalInputRow *row = [TPAnimalInputRow numberRowWithId:kAnimalNumberRowKey];
    row.text = self.model.number;
    return row;
}
- (TPAnimalSwitchRow *)sterilizationRow {
    TPAnimalSwitchRow *row = [TPAnimalSwitchRow sterilizationRowWithId:kAnimalSterilizationRowKey];
    row.on = self.model.isSterilization;
    return row;
}
- (TPAnimalSwitchRow *)dewormingRow {
    TPAnimalSwitchRow *row = [TPAnimalSwitchRow dewormingRowWithId:kAnimalDewormingRowKey];
    row.on = self.model.isDeworming;
    return row;
}
- (TPAnimalSwitchRow *)vaccineRow {
    TPAnimalSwitchRow *row = [TPAnimalSwitchRow vaccineRowWithId:kAnimalVaccineRowKey];
    row.on = self.model.isVaccine;
    return row;
}
- (TPAnimalAlertRow *)categoryRow {
    TPAnimalAlertRow *row = [TPAnimalAlertRow categoryRowWithId:kAnimalCategoryRowKey];
    row.text = [self categoryText];
    @weakify(self);
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        [TPUIAlert alertSheetShow:^(TPUIAlertMaker *make) {
            @strongify(self);
            make.title(@"萌宠类别");
            make.addOption(TPUIAlertColorOption(@"猫", ^{
                @strongify(self);
                if (self.model.category != TPAnimalCategoryCat) {
                    self.model.category = TPAnimalCategoryCat;
                    [self changedCategoryRow];
                }
            }, self.model.category == TPAnimalCategoryCat ? TPHelperThemeColor : TPHelperLightDarkTextColor));
            make.addOption(TPUIAlertColorOption(@"狗", ^{
                @strongify(self);
                if (self.model.category != TPAnimalCategoryDog) {
                    self.model.category = TPAnimalCategoryDog;
                    [self changedCategoryRow];
                }
            }, self.model.category == TPAnimalCategoryDog ? TPHelperThemeColor : TPHelperLightDarkTextColor));
            make.addOption(TPUIAlertColorOption(@"其他", ^{
                @strongify(self);
                if (self.model.category != TPAnimalCategoryOther) {
                    self.model.category = TPAnimalCategoryOther;
                    [self changedCategoryRow];
                }
            }, self.model.category == TPAnimalCategoryOther ? TPHelperThemeColor : TPHelperLightDarkTextColor));
            make.cancleOption(@"取消");
        }];
    };
    return row;
}
- (TPAnimalAlertRow *)genderRow {
    TPAnimalAlertRow *row = [TPAnimalAlertRow genderRowWithId:kAnimalGenderRowKey];
    row.text = [self genderText];
    @weakify(self);
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        [TPUIAlert alertSheetShow:^(TPUIAlertMaker *make) {
            make.title(@"萌宠性别");
            make.addOption(TPUIAlertColorOption(@"雌性", ^{
                @strongify(self);
                if (self.model.sexType != TPAnimalSexTypeFemale) {
                    self.model.sexType = TPAnimalSexTypeFemale;
                    [self changedGenderRow];
                }
            }, self.model.sexType == TPAnimalSexTypeFemale ? TPHelperThemeColor : TPHelperLightDarkTextColor));
            make.addOption(TPUIAlertColorOption(@"雄性", ^{
                @strongify(self);
                if (self.model.sexType != TPAnimalSexTypeMale) {
                    self.model.sexType = TPAnimalSexTypeMale;
                    [self changedGenderRow];
                }
            }, self.model.sexType == TPAnimalSexTypeMale ? TPHelperThemeColor : TPHelperLightDarkTextColor));
            make.cancleOption(@"取消");
        }];
    };
    return row;
}

- (void)changedCategoryRow {
    TPTableSection *section = self.tableview.TPProxy.data[0];
    TPAnimalAlertRow *row = section[kAnimalCategoryRowKey];
    row.text = [self categoryText];
}
- (void)changedGenderRow {
    TPTableSection *section = self.tableview.TPProxy.data[0];
    TPAnimalAlertRow *row = section[kAnimalGenderRowKey];
    row.text = [self genderText];
}
- (NSString *)categoryText {
    switch (self.model.category) {
        case TPAnimalCategoryCat: return @"猫"; break;
        case TPAnimalCategoryDog: return @"狗"; break;
        default: return @"其他"; break;
    }
}
- (NSString *)genderText {
    if (self.model.sexType == TPAnimalSexTypeFemale) {
        return @"雌性";
    }
    return @"雄性";
}
- (void)makeSureBtnAction {
    TPAnimalAvatarRow *avatarRow = [self fetchRow:kAnimalAvatarRowKey];
    if (!avatarRow.avatar) {
        [self.view tp_toast:@"请设置头像"];
        return;
    }
    self.model.thumbImage = avatarRow.avatar;
    
    // 姓名
    TPAnimalInputRow *nameRow = [self fetchRow:kAnimalNameRowKey];
    if (!nameRow.text) {
        [self.view tp_toast:@"请填写名称"];
        return;
    }
    self.model.name = nameRow.text;
    
    // 年龄
    TPAnimalInputRow *ageRow = [self fetchRow:kAnimalAgeRowKey];
    if (ageRow.text.integerValue == 0) {
        [self.view tp_toast:@"请填写年龄"];
        return;
    }
    self.model.age = ageRow.text.integerValue;
    
    /// 品种
    TPAnimalInputRow *breedRow = [self fetchRow:kAnimalBreedRowKey];
    if (!breedRow.text) {
        [self.view tp_toast:@"请填写品种"];
        return;
    }
    self.model.breed = breedRow.text;
    
    TPAnimalSwitchRow *sterilizationRow = [self fetchRow:kAnimalSterilizationRowKey];
    self.model.sterilization = sterilizationRow.isOn;
    
    TPAnimalSwitchRow *dewormingRow = [self fetchRow:kAnimalDewormingRowKey];
    self.model.deworming = dewormingRow.isOn;
    
    TPAnimalSwitchRow *vaccineRow = [self fetchRow:kAnimalVaccineRowKey];
    self.model.vaccine = vaccineRow.isOn;
    if (!self.animalModel) {
        self.model.userId = TPUserManager.manager.user.userId;
    }
    
    
    if (self.infoBlock) {
        self.infoBlock(self.model);
    }
    [TPUINavigator popViewControllerWithTimes:1 animated:YES];
}
- (__kindof TPTableRow *)fetchRow:(NSString *)key {
    TPTableSection *section = self.tableview.TPProxy.data[0];
    return section[key];
}
#pragma mark ==================  Getter   ==================
- (UIButton *)makeSureBtn {
    if (!_makeSureBtn) {
        _makeSureBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_makeSureBtn setTitle:@"创   建" forState:UIControlStateNormal];
        [_makeSureBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        [_makeSureBtn addTarget:self action:@selector(makeSureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _makeSureBtn.titleLabel.font = [TPUI tp_font:25 weight:FontMedium];
        _makeSureBtn.backgroundColor = UIColor.whiteColor;
        _makeSureBtn.layer.borderWidth = 0.6;
        _makeSureBtn.layer.borderColor = TPHelperThemeColor.CGColor;
        
    }
    return _makeSureBtn;
}
@end
