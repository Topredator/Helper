//
//  TPUserDetailVC.m
//  Helper
//
//  Created by Topredator on 2025/3/26.
//

#import "TPUserDetailVC.h"
#import "TPUserModule.h"
#import "TPUserModel.h"
#import "TPAddressModule.h"
#import "TPAddressModel.h"
#import "TPUserDetailRow.h"
#import "TPCommonSection.h"
@interface TPUserDetailVC ()
@property (nonatomic, strong) TPUserModel *user;
@property (nonatomic, copy) NSString *address;
@end

@implementation TPUserDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"用户详情";
    [self requestUserInfo];
}
- (void)requestUserInfo {
    [TPDBRouter sendTaskMessage:TPUserFetchUserInfo argument:[@{
        @"userId": self.userId
    } keyAddPrefix:TABLE_NAME_USER]];
}
- (void)loadData {
    TPCommonSection *section = [TPCommonSection section];
    [section addObject:[TPUserDetailRow avatarRow:@"头像" avatar:self.user.avatar]];
    [section addObject:[TPUserDetailRow rowWithTitle:@"名称" text:self.user.name]];
    [section addObject:[TPUserDetailRow rowWithTitle:@"联系方式" text:self.user.account]];
    [section addObject:[TPUserDetailRow rowWithTitle:@"年龄" text:self.user.age > 0 ? [NSString stringWithFormat:@"%ld", self.user.age] : @"未知"]];
    [section addObject:[TPUserDetailRow rowWithTitle:@"性别" text:self.user.gender == 0 ? @"男" : @"女"]];
    [section addObject:[TPUserDetailRow rowWithTitle:@"职业" text:self.user.perfession ?: @"暂无"]];
    [section addObject:[TPUserDetailRow rowWithTitle:@"地址" text:self.address ?: @"未设置"]];
    
    [self reloadData:@[section]];
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPUserFetchUserInfo) {
        NSArray *array = argument;
        if (!array.count) {
            [TPAppDelegate().window tp_toast:@"用户不存在"];
            [TPUINavigator popViewControllerWithTimes:1 animated:YES];
            return YES;
        }
        NSDictionary *dic = array.firstObject;
        self.user = [TPUserModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_USER]];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            TPAddressModel *addressModel = [TPDBRouter syncSendTaskMessage:TPAddressFetchUserDefaultAddress argument:self.user.userId];
            self.address = addressModel.detailAddress;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadData];
            });
        });
        return YES;
    }
    return NO;
}
@end
