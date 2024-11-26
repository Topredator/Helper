//
//  TPForgotPwdVC.m
//  Helper
//
//  Created by Topredator on 2024/11/25.
//

#import "TPForgotPwdVC.h"
#import "TPAuthLogoRow.h"
#import "TPAuthTextFieldRow.h"
#import "TPAuthButtonRow.h"
#import "TPCommonSection.h"
#import "TPNavigationView.h"

@interface TPForgotPwdVC ()
@property (nonatomic, strong) TPNavigationView *navigationView;
@end

@implementation TPForgotPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
}
- (void)setupTableView {
    [super setupTableView];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(TPUI.tp_topBarHeight);
    }];
    self.tableview.hidden = NO;
    self.tableview.backgroundColor = UIColor.whiteColor;
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(TPUI.tp_topBarHeight, 0, 0, 0));
    }];
}
- (void)loadData {
    // logo
    TPAuthLogoRow *logoRow = [TPAuthLogoRow row];
    // old password
    TPAuthTextFieldRow *accountRow = [TPAuthTextFieldRow accountRow];
    // new password
    TPAuthTextFieldRow *newPwdRow = [TPAuthTextFieldRow rowWithId:kTPAuthNewPasswordRowKey placeholder:@"新密码"];
    // sure passwor
    TPAuthTextFieldRow *surePwdRow = [TPAuthTextFieldRow rowWithId:kTPAuthSurePasswordRowKey placeholder:@"确认密码"];
    
    // login button
    TPAuthButtonRow *changeBtnRow = [TPAuthButtonRow changePwdRowWithAccount:RACObserve(accountRow, text) newPwd:RACObserve(newPwdRow, text) surePwd:RACObserve(surePwdRow, text)];
    [changeBtnRow setTarget:self action:@selector(changePwd)];
  
    [self reloadData:@[
        [TPCommonSection arrayWithObject:logoRow],
        [TPCommonSection arrayWithObjects:accountRow, newPwdRow, surePwdRow, nil],
        [TPCommonSection arrayWithObjects:changeBtnRow, nil]
    ]];
}
- (void)changePwd {
    TPTableSection *section = self.tableview.TPProxy.data[1];
    NSString *account = [(TPAuthTextFieldRow *)section[kTPAuthAccountRowKey] text];
    NSString *newPwd = [(TPAuthTextFieldRow *)section[kTPAuthNewPasswordRowKey] text];
    NSString *surePwd = [(TPAuthTextFieldRow *)section[kTPAuthSurePasswordRowKey] text];
    if (![newPwd isEqualToString:surePwd]) {
        [self.view tp_toast:@"密码不一致"];
        return;
    }
    TPUserModel *existModel = [TPDBRouter syncSendTaskMessage:TPUserModuleSingleQuery argument:[@{
       @"account": account
   } keyAddPrefix:TABLE_NAME_USER]];
    if (!existModel) {
        [self.view tp_toast:@"账号输入有误"];
        return;
    }
    // 开始数据库 修改密码操作
    [TPDBRouter sendTaskMessage:TPUserModuleChangePassword argument:@{
        @"account": account,
        @"password": newPwd
    }];
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPUserModuleChangePassword) {
        [[self.view tp_toast:@"密码设置成功，请登录"] setCompletionBlock:^{
            [TPAppDelegate() tp_resetWindow];
        }];
        return YES;
    }
    return NO;
}

#pragma mark----------------- Getter -----------------
- (TPNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [TPNavigationView backView];
        _navigationView.title = @"忘记密码";
        _navigationView.showLines = YES;
    }
    return _navigationView;
}
@end
