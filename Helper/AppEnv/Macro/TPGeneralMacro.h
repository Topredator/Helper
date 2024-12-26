//
//  TPGeneralMacro.h
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

/// 登录页 identifer
static NSString *kTPAuthAccountRowKey = @"com.helper.auth.row.account";
static NSString *kTPAuthPasswordRowKey = @"com.helper.auth.row.password";
static NSString *kTPAuthOldPasswordRowKey = @"com.helper.auth.row.oldPassword";
static NSString *kTPAuthNewPasswordRowKey = @"com.helper.auth.row.newPassword";
static NSString *kTPAuthSurePasswordRowKey = @"com.helper.auth.row.surePassword";

static NSString *kTPAuthButtonKey = @"com.helper.auth.button.row";
static NSString *kTPAuthLoginRowKey = @"com.helper.auth.login.row";
static NSString *kTPAuthRegisterRowKey = @"com.helper.auth.register.row";

#pragma mark----------------- 用户模块 -----------------
/// 最近登录的账号
static NSString *const kTPUserLatestAccount = @"com.helper.user.default.latestaccount";
/// 用户token
static NSString *const kTPUserToken = @"com.helper.user.default.token";

/// 默认主题颜色
#define TPHelperThemeColor [TPUI tp_r:52 g:152 b:219]
/// 禁用颜色
#define TPHelperDisabledColor [TPUI tp_r:169 g:169 b:169]
/// 默认背景色
#define TPHelperDefaultBgColor [TPUI tp_r:235 g:235 b:235]

#define TPHelperDarkGrayTextColor [TPUI tp_r:102 g:102 b:102]
#define TPHelperDarkTextColor [TPUI tp_r:51 g:51 b:51]
#define TPHelperLightDarkTextColor [TPUI tp_r:153 g:153 b:153]
#import "AppDelegate+TPWindow.h"
NS_INLINE AppDelegate *TPAppDelegate(void) { return (AppDelegate *)[UIApplication sharedApplication].delegate; }


