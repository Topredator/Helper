//
//  TPReleaseAdoptVC.m
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPReleaseAdoptVC.h"
#import "TPAnimalModel.h"
#import "TPAnimalInputRow.h"
#import "TPCommonTitleSection.h"
#import "TPAnimalSwitchRow.h"
#import "TPAnimalAlertRow.h"
#import "TPAdoptModel.h"

static NSString *kReleaseAdoptName = @"releaseAdoptName";
static NSString *kReleaseAdoptAge = @"releaseAdoptAge";
static NSString *kReleaseAdoptBreed = @"releaseAdoptBreed";
static NSString *kReleaseAdoptNumber = @"releaseAdoptNumber";
static NSString *kReleaseAdoptSterilization = @"releaseAdoptSterilization";
static NSString *kReleaseAdoptDeworming = @"releaseAdoptDeworming";
static NSString *kReleaseAdoptVaccine = @"releaseAdoptVaccine";
static NSString *kReleaseAdoptCategory = @"releaseAdoptCategory";
static NSString *kReleaseAdoptGender = @"releaseAdoptGender";
@interface TPReleaseAdoptVC ()
@property (nonatomic, strong) TPAnimalModel *animalModel;
/// 发布按钮
@property (nonatomic, strong) UIButton *publicBtn;
@end

@implementation TPReleaseAdoptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.title = @"发布领养";
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.publicBtn];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-60 - TPUI.tp_bottomSafeAreaHeight);
    }];
    [self.publicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(TPUI.tp_screenWidth - 60, 50));
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-5 - TPUI.tp_bottomSafeAreaHeight);
    }];
}
- (void)loadData {
    TPCommonTitleSection *section = [TPCommonTitleSection sectionWithTitle:@"萌宠信息"];
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
- (TPAnimalInputRow *)nameRow {
    TPAnimalInputRow *row = [TPAnimalInputRow nameRowWithId:kReleaseAdoptName];
    row.text = self.animalModel.name;
    return row;
}
- (TPAnimalInputRow *)ageRow {
    TPAnimalInputRow *row = [TPAnimalInputRow ageRowWithId:kReleaseAdoptAge];
    row.text = [NSString stringWithFormat:@"%ld", self.animalModel.age];
    return row;
}
- (TPAnimalInputRow *)breedRow {
    TPAnimalInputRow *row = [TPAnimalInputRow breedRowWithId:kReleaseAdoptBreed];
    row.text = self.animalModel.breed;
    return row;
}
- (TPAnimalInputRow *)numberRow {
    TPAnimalInputRow *row = [TPAnimalInputRow numberRowWithId:kReleaseAdoptNumber];
    row.text = self.animalModel.number;
    return row;
}
- (TPAnimalSwitchRow *)sterilizationRow {
    TPAnimalSwitchRow *row = [TPAnimalSwitchRow sterilizationRowWithId:kReleaseAdoptSterilization];
    row.on = self.animalModel.isSterilization;
    return row;
}
- (TPAnimalSwitchRow *)dewormingRow {
    TPAnimalSwitchRow *row = [TPAnimalSwitchRow dewormingRowWithId:kReleaseAdoptDeworming];
    row.on = self.animalModel.isDeworming;
    return row;
}
- (TPAnimalSwitchRow *)vaccineRow {
    TPAnimalSwitchRow *row = [TPAnimalSwitchRow vaccineRowWithId:kReleaseAdoptVaccine];
    row.on = self.animalModel.isVaccine;
    return row;
}
- (TPAnimalAlertRow *)categoryRow {
    TPAnimalAlertRow *row = [TPAnimalAlertRow categoryRowWithId:kReleaseAdoptCategory];
    row.text = [self categoryText];
    @weakify(self);
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        [TPUIAlert alertSheetShow:^(TPUIAlertMaker *make) {
            @strongify(self);
            make.title(@"萌宠类别");
            make.addOption(TPUIAlertColorOption(@"猫", ^{
                @strongify(self);
                if (self.animalModel.category != TPAnimalCategoryCat) {
                    self.animalModel.category = TPAnimalCategoryCat;
                    [self changedCategoryRow];
                }
            }, self.animalModel.category == TPAnimalCategoryCat ? TPHelperThemeColor : TPHelperLightDarkTextColor));
            make.addOption(TPUIAlertColorOption(@"狗", ^{
                @strongify(self);
                if (self.animalModel.category != TPAnimalCategoryDog) {
                    self.animalModel.category = TPAnimalCategoryDog;
                    [self changedCategoryRow];
                }
            }, self.animalModel.category == TPAnimalCategoryDog ? TPHelperThemeColor : TPHelperLightDarkTextColor));
            make.addOption(TPUIAlertColorOption(@"其他", ^{
                @strongify(self);
                if (self.animalModel.category != TPAnimalCategoryOther) {
                    self.animalModel.category = TPAnimalCategoryOther;
                    [self changedCategoryRow];
                }
            }, self.animalModel.category == TPAnimalCategoryOther ? TPHelperThemeColor : TPHelperLightDarkTextColor));
            make.cancleOption(@"取消");
        }];
    };
    return row;
}
- (TPAnimalAlertRow *)genderRow {
    TPAnimalAlertRow *row = [TPAnimalAlertRow genderRowWithId:kReleaseAdoptGender];
    row.text = [self genderText];
    @weakify(self);
    row.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        [TPUIAlert alertSheetShow:^(TPUIAlertMaker *make) {
            make.title(@"萌宠性别");
            make.addOption(TPUIAlertColorOption(@"雌性", ^{
                @strongify(self);
                if (self.animalModel.sexType != TPAnimalSexTypeFemale) {
                    self.animalModel.sexType = TPAnimalSexTypeFemale;
                    [self changedGenderRow];
                }
            }, self.animalModel.sexType == TPAnimalSexTypeFemale ? TPHelperThemeColor : TPHelperLightDarkTextColor));
            make.addOption(TPUIAlertColorOption(@"雄性", ^{
                @strongify(self);
                if (self.animalModel.sexType != TPAnimalSexTypeMale) {
                    self.animalModel.sexType = TPAnimalSexTypeMale;
                    [self changedGenderRow];
                }
            }, self.animalModel.sexType == TPAnimalSexTypeMale ? TPHelperThemeColor : TPHelperLightDarkTextColor));
            make.cancleOption(@"取消");
        }];
    };
    return row;
}

- (void)changedCategoryRow {
    TPTableSection *section = self.tableview.TPProxy.data[0];
    TPAnimalAlertRow *row = section[kReleaseAdoptCategory];
    row.text = [self categoryText];
}
- (void)changedGenderRow {
    TPTableSection *section = self.tableview.TPProxy.data[0];
    TPAnimalAlertRow *row = section[kReleaseAdoptGender];
    row.text = [self genderText];
}
- (NSString *)categoryText {
    switch (self.animalModel.category) {
        case TPAnimalCategoryCat: return @"猫"; break;
        case TPAnimalCategoryDog: return @"狗"; break;
        default: return @"其他"; break;
    }
}
- (NSString *)genderText {
    if (self.animalModel.sexType == TPAnimalSexTypeFemale) {
        return @"雌性";
    }
    return @"雄性";
}
- (void)publicBtnAction {
    // 姓名
    TPAnimalInputRow *nameRow = [self fetchRow:kReleaseAdoptName];
    if (!nameRow.text) {
        [self.view tp_toast:@"请填写名称"];
        return;
    }
    self.animalModel.name = nameRow.text;
    
    // 年龄
    TPAnimalInputRow *ageRow = [self fetchRow:kReleaseAdoptAge];
    if (ageRow.text.integerValue == 0) {
        [self.view tp_toast:@"请填写年龄"];
        return;
    }
    self.animalModel.age = ageRow.text.integerValue;
    
    /// 品种
    TPAnimalInputRow *breedRow = [self fetchRow:kReleaseAdoptBreed];
    if (!breedRow.text) {
        [self.view tp_toast:@"请填写品种"];
        return;
    }
    self.animalModel.breed = breedRow.text;
    
    TPAnimalSwitchRow *sterilizationRow = [self fetchRow:kReleaseAdoptSterilization];
    self.animalModel.sterilization = sterilizationRow.isOn;
    
    TPAnimalSwitchRow *dewormingRow = [self fetchRow:kReleaseAdoptDeworming];
    self.animalModel.deworming = dewormingRow.isOn;
    
    TPAnimalSwitchRow *vaccineRow = [self fetchRow:kReleaseAdoptVaccine];
    self.animalModel.vaccine = vaccineRow.isOn;
    
    self.animalModel.coverImage = self.animalModel.category == TPAnimalCategoryDog ? [NSString stringWithFormat:@"banner_dog_%u", arc4random() % 15 + 1] : [NSString stringWithFormat:@"banner_cat_%u", arc4random() % 15 + 1];
    self.animalModel.thumbImage = self.animalModel.category == TPAnimalCategoryDog ? [NSString stringWithFormat:@"dog_avatar_%u", arc4random() % 30 + 1] : [NSString stringWithFormat:@"cat_avatar_%u", arc4random() % 30 + 1];
    self.animalModel.createTime = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
    
    [TPDBRouter sendTaskMessage:TPAnimalModuleRegist argument:[self.animalModel tp_modelToJSONObject]];
}
- (__kindof TPTableRow *)fetchRow:(NSString *)key {
    TPTableSection *section = self.tableview.TPProxy.data[0];
    return section[key];
}

- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPAnimalModulePublicAdopt) { // 发布领养
        [TPAppDelegate().window tp_toast:@"发布成功"];
        [self.navigationController popViewControllerAnimated:YES];
        return YES;
    }
    return NO;
}

#pragma mark----------------- Getter -----------------
- (TPAnimalModel *)animalModel {
    if (!_animalModel) {
        _animalModel = [TPAnimalModel generateModel];
    }
    return _animalModel;
}
- (UIButton *)publicBtn {
    if (!_publicBtn) {
        _publicBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_publicBtn setTitle:@"发   布" forState:UIControlStateNormal];
        [_publicBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        [_publicBtn addTarget:self action:@selector(publicBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _publicBtn.titleLabel.font = [TPUI tp_font:25 weight:FontMedium];
        _publicBtn.backgroundColor = UIColor.whiteColor;
        _publicBtn.layer.borderWidth = 0.6;
        _publicBtn.layer.borderColor = TPHelperThemeColor.CGColor;
        
    }
    return _publicBtn;
}
@end
