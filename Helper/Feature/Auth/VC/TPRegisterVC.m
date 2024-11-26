//
//  TPRegisterVC.m
//  Helper
//
//  Created by Topredator on 2024/10/17.
//

#import "TPRegisterVC.h"
#import "TPAuthLogoRow.h"
#import "TPAuthTextFieldRow.h"
#import "TPAuthButtonRow.h"
#import "TPCommonSection.h"
#import "TPNavigationView.h"
#import "TPUserModule.h"

@interface TPRegisterVC ()
@property (nonatomic, strong) TPNavigationView *navigationView;
@end

@implementation TPRegisterVC

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
    // account
    TPAuthTextFieldRow *accountRow = [TPAuthTextFieldRow accountRow];
    // password
    TPAuthTextFieldRow *pwdRow = [TPAuthTextFieldRow passwordRow];
    // login button
    TPAuthButtonRow *registerRow = [TPAuthButtonRow registerRowWithAccount:RACObserve(accountRow, text) pwd:RACObserve(pwdRow, text)];
    [registerRow setTarget:self action:@selector(startRegister)];
    [self reloadData:@[
        [TPCommonSection arrayWithObject:logoRow],
        [TPCommonSection arrayWithObjects:accountRow, pwdRow, nil],
        [TPCommonSection arrayWithObjects:registerRow, nil]
    ]];
}
- (void)startRegister {
    TPTableSection *section = self.tableview.TPProxy.data[1];
    NSString *account = [(TPAuthTextFieldRow *)section[kTPAuthAccountRowKey] text];
    NSString *password = [(TPAuthTextFieldRow *)section[kTPAuthPasswordRowKey] text];
    
    // 查询账号是否已经注册
    id existModel = [TPDBRouter syncSendTaskMessage:TPUserModuleSingleQuery argument:[@{
        @"account": account
    } keyAddPrefix:TABLE_NAME_USER]];
    
    if (existModel) {
        [self.view tp_toast:@"用户已注册"];
        return;
    }
    
    [TPUserManager.manager registerWithAccount:account password:password];
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPUserModuleRegister) {
        [self.view tp_toast:@"注册成功"];
        [self loadData];
        return YES;
    }
    return NO;
}
#pragma mark----------------- Getter -----------------
- (TPNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [TPNavigationView backView];
        _navigationView.title = @"注册";
        _navigationView.showLines = YES;
    }
    return _navigationView;
}
@end
