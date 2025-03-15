//
//  TPUserModule.m
//  Helper
//
//  Created by Topredator on 2024/11/25.
//

#import "TPUserModule.h"
#import "TPUserDao.h"
#import "TPUserModel.h"


/// 用户表
#define CREATE_TABLE_USER   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_USER                \
"("                                             \
" User_userId"             " TEXT PRIMARY KEY,"        \
" User_name"           " TEXT,"                     \
" User_avatar"          " TEXT,"                    \
" User_age"         " INTEGER default 18,"                    \
" User_account"           " TEXT,"                     \
" User_password"         " TEXT,"                     \
" User_userType"      " INTEGER,"                     \
" User_gender"         " INTEGER default 0,"                    \
" User_idCard"          " TEXT,"           \
" User_token"            " TEXT,"                      \
" User_perfession"            " TEXT,"                      \
" User_createTime"        " TEXT"            \
")"


@implementation TPUserModule
+ (void)updateDBOnLaunching:(FMDatabase *)db {
    [db executeUpdate:CREATE_TABLE_USER];
}
+ (BOOL)handleTaskMessage:(TPDBTaskMessage *)msg {
    NSInteger messageType = msg.taskMsgType;
    id argument = msg.argument;
    TPUserDao *dao = [TPUserDao daoWithTableName:TABLE_NAME_USER];
    
    switch (messageType) {
        case TPUserModuleSingleQuery: { // 用户查询
            NSArray *users = [dao search:argument messageType:0 waitUntilDone:YES];
            NSArray *maps = ASTMap(users, ^id(NSDictionary *obj, NSUInteger idx) {
                return [TPUserModel tp_modelWithDictionary:[obj keyRemovePrefix:TABLE_NAME_USER]];
            });
            msg.result = maps.count > 0 ? maps.firstObject : nil;
            return YES;
        }
        case TPUserModuleRegister: { // 用户注册
            [dao save:argument messageType:messageType waitUntilDone:NO igoner:YES];
            return YES;
        }
        case TPUserModuleChangePassword: { // 修改密码
            NSDictionary *dic = argument;
            NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET User_password = '%@' WHERE User_account = '%@'", dao.tableName, dic[@"password"], dic[@"account"]];
            [dao update:sql parameter:nil messageType:messageType waitUntilDone:NO];
            return YES;
        }
        case TPUserModuleUpdateUserInfo: { // 更新用户信息
            NSDictionary *dic = argument;
            [dao update:[dic keyAddPrefix:TABLE_NAME_USER] ByPrimeKeyValue:TPUserManager.manager.user.userId messageType:messageType waitUntilDone:NO];
            return YES;
        }
        default:
            break;
    }
    return NO;
}
@end
