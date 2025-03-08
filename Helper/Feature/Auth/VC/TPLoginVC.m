//
//  TPLoginVC.m
//  Helper
//
//  Created by Topredator on 2024/10/14.
//

#import "TPLoginVC.h"
#import "FBShimmeringView.h"
#import "TPCommonSection.h"
#import "TPAuthLogoRow.h"
#import "TPAuthTextFieldRow.h"
#import "TPAuthButtonRow.h"
#import "TPAuthLoginActionRow.h"
#import "TPRegisterVC.h"
#import "TPUserModule.h"
#import "TPForgotPwdVC.h"

@interface TPLoginVC ()

@end

@implementation TPLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self setupNotify];
}
- (void)setupSubviews {
    [super setupSubviews];
    self.tableview.hidden = NO;
    self.tableview.backgroundColor = UIColor.whiteColor;
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)setupNotify {
    [self tp_observeNotificationByName:TPNotifyUserDidLogin withNotifyBlock:^(NSNotification * _Nonnull note) {
        [TPAppDelegate() tp_resetWindowAfterLogin];
    }];
}
- (void)loadData {
    // logo
    TPAuthLogoRow *logoRow = [TPAuthLogoRow row];
    // account
    TPAuthTextFieldRow *accountRow = [TPAuthTextFieldRow accountRow];
    accountRow.text = TPUserManager.manager.latestAccount;
    // password
    TPAuthTextFieldRow *pwdRow = [TPAuthTextFieldRow passwordRow];
    // login button
    TPAuthButtonRow *loginBtnRow = [TPAuthButtonRow loginRowWithAccount:RACObserve(accountRow, text) password:RACObserve(pwdRow, text)];
    [loginBtnRow setTarget:self action:@selector(startLogin)];
    // register、forgotPassword
    TPAuthLoginActionRow *loginActionRow = [TPAuthLoginActionRow rowWithTarget:self
                                                                registerAction:@selector(startRegister)
                                                               forgotPwdAction:@selector(forgotPassword)];
    [self reloadData:@[
        [TPCommonSection arrayWithObject:logoRow],
        [TPCommonSection arrayWithObjects:accountRow, pwdRow, nil],
        [TPCommonSection arrayWithObjects:loginBtnRow, loginActionRow, nil]
    ]];
}
/// 登录
- (void)startLogin {
    TPTableSection *section = self.tableview.TPProxy.data[1];
    NSString *account = [(TPAuthTextFieldRow *)section[kTPAuthAccountRowKey] text];
    NSString *password = [(TPAuthTextFieldRow *)section[kTPAuthPasswordRowKey] text];
    
    // 查询账号是否已经注册
    TPUserModel *existModel = [TPDBRouter syncSendTaskMessage:TPUserModuleSingleQuery argument:[@{
       @"account": account
   } keyAddPrefix:TABLE_NAME_USER]];
    
    if (!existModel) {
        [self.view tp_toast:@"用户不存在"];
        return;
    }
    if (![existModel.password isEqualToString:password]) {
        [self.view tp_toast:@"密码不正确"];
        return;
    }
    [TPUserManager.manager setLoginUser:existModel];
}
/// 注册
- (void)startRegister {
    [self.navigationController pushViewController:TPRegisterVC.new animated:YES];
}
/// 忘记密码
- (void)forgotPassword {
    [self.navigationController pushViewController:TPForgotPwdVC.new animated:YES];
}

@end
