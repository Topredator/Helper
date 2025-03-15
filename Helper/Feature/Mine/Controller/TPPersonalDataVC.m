//
//  TPPersonalDataVC.m
//  Helper
//
//  Created by Topredator on 2025/3/11.
//

#import "TPPersonalDataVC.h"
#import "TPCommonSection.h"
#import "TPPersonalRow.h"
#import "TPImagePickerVC.h"
#import "TPPersonalDetailVC.h"
@interface TPPersonalDataVC ()
@property (nonatomic, strong) TPCommonSection *section;
@property (nonatomic, strong) TPUserModel *user;
@end

@implementation TPPersonalDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"个人资料";
    self.user = TPUserManager.manager.user;
    [self loadData];
}
- (void)loadData {
    [self.section removeAllObjects];
    [self.section addObject:[self avatarRow]];
    [self.section addObject:[self nameRow]];
    [self.section addObject:[self ageRow]];
    [self.section addObject:[self genderRow]];
    [self.section addObject:[self perfessionRow]];
    
    
    [self reloadData:@[self.section]];
}
- (TPPersonalRow *)avatarRow {
    TPPersonalRow *avatarRow = [TPPersonalRow rowWithTitle:@"头像" text:self.user.avatar isAvatar:YES identify:@""];
    @weakify(self);
    avatarRow.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        TPImagePickerVC *pickerVC = [TPImagePickerVC new];
        pickerVC.total = 35;
        pickerVC.column = 3;
        pickerVC.namePrefix = @"user_avatar_";
        pickerVC.singleBlock = ^(NSString * _Nonnull imageName) {
            @strongify(self);
            self.user.avatar = imageName;
            [TPDBRouter sendTaskMessage:TPUserModuleUpdateUserInfo argument:[self.user tp_modelToJSONObject]];
        };
        [TPUINavigator pushViewController:pickerVC animated:YES];
    };
    return avatarRow;
}
- (TPPersonalRow *)nameRow {
    TPPersonalRow *nameRow = [TPPersonalRow rowWithTitle:@"名称" text:self.user.name isAvatar:NO identify:@""];
    @weakify(self);
    nameRow.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        @strongify(self);
        TPPersonalDetailVC *detailVC = [TPPersonalDetailVC new];
        detailVC.navigationTitle = @"名称";
        detailVC.content = self.user.name;
        detailVC.callback = ^(NSString * _Nonnull content) {
            @strongify(self);
            self.user.name = content;
            [TPDBRouter sendTaskMessage:TPUserModuleUpdateUserInfo argument:[self.user tp_modelToJSONObject]];
        };
        [TPUINavigator pushViewController:detailVC animated:YES];
    };
    return nameRow;
}
- (TPPersonalRow *)genderRow {
    TPPersonalRow *genderRow = [TPPersonalRow rowWithTitle:@"性别" text:self.user.gender == 0 ? @"男" : @"女" isAvatar:NO identify:@""];
    @weakify(self);
    genderRow.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        [TPUIAlert alertSheetShow:^(TPUIAlertMaker *make) {
            @strongify(self);
            make.title(@"性别").message(@"请选择");
            make.addOption(TPUIAlertColorOption(@"男", ^{
                @strongify(self);
                if (self.user.gender == 0) return;
                self.user.gender = 0;
                [TPDBRouter sendTaskMessage:TPUserModuleUpdateUserInfo argument:[self.user tp_modelToJSONObject]];
            }, self.user.gender == 0 ? TPHelperThemeColor : TPHelperLightDarkTextColor));
            make.addOption(TPUIAlertColorOption(@"女", ^{
                @strongify(self);
                if (self.user.gender == 1) return;
                self.user.gender = 1;
                [TPDBRouter sendTaskMessage:TPUserModuleUpdateUserInfo argument:[self.user tp_modelToJSONObject]];
            }, self.user.gender == 1 ? TPHelperThemeColor : TPHelperLightDarkTextColor));
            make.cancleOption(@"取消");
        }];
    };
    return genderRow;
}
- (TPPersonalRow *)ageRow {
    TPPersonalRow *ageRow = [TPPersonalRow rowWithTitle:@"年龄" text:[NSString stringWithFormat:@"%ld", self.user.age] isAvatar:NO identify:@""];
   
    @weakify(self);
    ageRow.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        @strongify(self);
        TPPersonalDetailVC *detailVC = [TPPersonalDetailVC new];
        detailVC.navigationTitle = @"年龄";
        detailVC.keyboardType = UIKeyboardTypeNumberPad;
        detailVC.content = [NSString stringWithFormat:@"%ld", self.user.age];
        detailVC.callback = ^(NSString * _Nonnull content) {
            @strongify(self);
            self.user.age = content.integerValue;
            [TPDBRouter sendTaskMessage:TPUserModuleUpdateUserInfo argument:[self.user tp_modelToJSONObject]];
        };
        [TPUINavigator pushViewController:detailVC animated:YES];
    };
    return ageRow;
}
- (TPPersonalRow *)perfessionRow {
    TPPersonalRow *perfessionRow = [TPPersonalRow rowWithTitle:@"职业" text:self.user.perfession ?: @"暂无" isAvatar:NO identify:@""];
    @weakify(self);
    perfessionRow.cellDidSelected = ^(__kindof TPTableRow * _Nonnull rowData, TPTableViewProxy * _Nonnull proxy, NSIndexPath * _Nonnull indexPath) {
        @strongify(self);
        TPPersonalDetailVC *detailVC = [TPPersonalDetailVC new];
        detailVC.navigationTitle = @"职业";
        detailVC.content = self.user.perfession;
        detailVC.callback = ^(NSString * _Nonnull content) {
            @strongify(self);
            self.user.perfession = content;
            [TPDBRouter sendTaskMessage:TPUserModuleUpdateUserInfo argument:[self.user tp_modelToJSONObject]];
        };
        [TPUINavigator pushViewController:detailVC animated:YES];
    };
    return perfessionRow;
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPUserModuleUpdateUserInfo) {
        TPUserManager.manager.user = self.user;
        [self loadData];
    }
    return NO;
}
#pragma mark ==================  Getter   ==================
- (TPCommonSection *)section {
    if (!_section) {
        _section = [TPCommonSection section];
    }
    return _section;
}
@end
