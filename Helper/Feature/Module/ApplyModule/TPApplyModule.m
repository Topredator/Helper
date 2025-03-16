//
//  TPApplyModule.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPApplyModule.h"
#import "TPApplyModel.h"
#import "TPApplyDao.h"

/// 创建 申请表
#define CREATE_TABLE_APPLY   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_APPLY                \
"("                                             \
" Apply_applyId"             " TEXT PRIMARY KEY,"        \
" Apply_publishId"         " TEXT,"                     \
" Apply_applicantId"         " TEXT,"                     \
" Apply_respondentId"         " TEXT,"                     \
" Apply_adminId"         " TEXT,"                     \
" Apply_type"         " INTEGER default (0),"                    \
" Apply_applyStatus"         " INTEGER default (1),"                    \
" Apply_createTime"         " TEXT,"                     \
" Apply_endTime"         " TEXT,"                     \
" Apply_refusalReason"         " TEXT"                     \
")"

@implementation TPApplyModule
+ (void)updateDBOnLaunching:(FMDatabase *)db {
    [db executeUpdate:CREATE_TABLE_APPLY];
}
+ (BOOL)handleTaskMessage:(TPDBTaskMessage *)msg {
    NSInteger messageType = msg.taskMsgType;
    id argument = msg.argument;
    TPBaseDao *dao = [TPBaseDao daoWithTableName:TABLE_NAME_APPLY];
    if (messageType == TPApplyToAdmin) {
        NSDictionary *dic = argument;
        // 查询是否申请过
        NSArray *res = [dao search:@{
            @"applicantId": [dic tp_StringObjectForKey:@"applicantId"] ?: @"",
            @"respondentId" : [dic tp_StringObjectForKey:@"respondentId"] ?: @"",
            @"animalId": [dic tp_StringObjectForKey:@"animalId"] ?: @"",
        } messageType:0 waitUntilDone:YES];
        if (res.count) {
            [TPDBRouter sendMessageToRoutes:TPApplyToAdminWaiting result:0 argument:nil];
            return YES;
        }
        [dao save:dic messageType:messageType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPFetchApplyList) {
//        NSString *sql = [NSString stringWithFormat:@"SELECT a.*, u.* FROM %@ a  INNER JOIN %@ u ON a.Apply_userId = u.User_userId WHERE a.Apply_applyStatus = 1", TABLE_NAME_APPLY, TABLE_NAME_USER];
        // json_object('userId', u1.userId, 'name', u1.name, 'age', u1.age, 'gender', u1.gender, 'phone', u1.phone) AS user
        NSString *sql = [NSString stringWithFormat:@"SELECT a.*,  json_object('userId', u.User_userId, 'name', u.User_name, 'account', u.User_account, 'avatar', u.User_avatar) AS applicant FROM %@ a  INNER JOIN %@ u ON a.Apply_userId = u.User_userId WHERE a.Apply_applyStatus = 1", TABLE_NAME_APPLY, TABLE_NAME_USER];
        [dao searchWithSQL:sql messageType:messageType waitUntilDone:NO];
        return YES;
    }
    return NO;
}
@end
