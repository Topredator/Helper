//
//  TPUserManager.m
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import "TPUserManager.h"

@interface TPUserManager ()
@property (nonatomic, copy) NSString *userArchiverPath;
@end

static TPUserManager *manager = nil;
@implementation TPUserManager
@synthesize user = _user;
+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [TPUserManager new];
    });
    return manager;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.userArchiverPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"TPUserModel.archiver"];
        if (self.token.length && ![NSFileManager.defaultManager fileExistsAtPath:self.userArchiverPath]) {
            [TPCommonUD UDRemoveKey:kTPUserToken];
        }
    }
    return self;
}
/// 是否登录
- (BOOL)isLogin {
    return (self.token.length > 0);
}

/// 获取最近登录的账号
- (NSString *)latestAccount {
    return [TPCommonUD UDStrKey:kTPUserLatestAccount];
}
- (NSString *)token {
    if (!_token) {
        _token = [TPCommonUD UDStrKey:kTPUserToken] ?: @"";
    }
    return _token;
}
- (void)setUser:(TPUserModel *)user {
    [self willChangeValueForKey:@"user"];
    _user = user;
    NSError *error;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user requiringSecureCoding:YES error:&error];
    
    [data writeToFile:self.userArchiverPath atomically:YES];
    [self didChangeValueForKey:@"user"];
}
- (TPUserModel *)user {
    if (!_user && [self isLogin]) {
        if ([NSFileManager.defaultManager fileExistsAtPath:self.userArchiverPath]) {
            _user = [NSKeyedUnarchiver unarchiveObjectWithFile:self.userArchiverPath];
        }
    }
    return _user;
}
- (void)setLoginUser:(TPUserModel *)user {
    self.user = user;
    self.token = user.token;
    /// 保存登录后的token
    [TPCommonUD UDStr:user.token key:kTPUserToken];
    /// 保存登录的账号
    [TPCommonUD UDStr:user.account key:kTPUserLatestAccount];
    /// 登录成功通知
    [NSNotificationCenter.defaultCenter postNotificationName:TPNotifyUserDidLogin object:nil];
}
- (void)registerWithAccount:(NSString *)account password:(NSString *)password {
    TPUserModel *user = [TPUserModel userAccount:account pwd:password type:TPUserTypeCustome];
    [TPDBRouter sendTaskMessage:TPUserModuleRegister argument:[user tp_modelToJSONObject]];
}

/// 设置登出状态
- (void)setLogout {
    NSString *oldToken = self.token;
    NSMutableDictionary *oldInfo = @{}.mutableCopy;
    [oldInfo tp_safetySetObject:[self.user.userId copy] forKey:@"userId"];
    [oldInfo tp_safetySetObject:oldToken forKey:@"token"];
    
    self.token = @"";
    self.user = nil;
    [TPCommonUD UDRemoveKey:kTPUserToken];
    [NSNotificationCenter.defaultCenter postNotificationName:TPNotifyUserDidLogout object:oldToken];
}
@end
