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
" Apply_animalId"         " TEXT,"                     \
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
    if (messageType == TPApplyToAdoptAnimal) {
        NSDictionary *dic = argument;
        // 查询是否申请过
        NSArray *res = [dao search:[@{
            @"applicantId": [dic tp_StringObjectForKey:@"applicantId"] ?: @"",
            @"respondentId" : [dic tp_StringObjectForKey:@"respondentId"] ?: @"",
            @"animalId": [dic tp_StringObjectForKey:@"animalId"] ?: @"",
        } keyAddPrefix:TABLE_NAME_APPLY] messageType:0 waitUntilDone:YES];
        if (res.count) {
            [TPDBRouter sendMessageToRoutes:TPApplyToAdminWaiting result:0 argument:nil];
            return YES;
        }
        [dao save:dic messageType:messageType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPFetchUserApplyDatas ||
               messageType == TPFetchUserApplyMoreDatas) {
        NSDictionary *dic = argument;
        NSString *userId = [dic tp_StringObjectForKey:@"userId"];
        NSInteger pageNo = [dic tp_IntegerObjectForKey:@"pageNo"];
        NSInteger pageSize = [dic tp_IntegerObjectForKey:@"pageSize"];
        
        NSString *sql = [NSString stringWithFormat:@"SELECT a.*, u.*, an.* FROM %@ a INNER JOIN %@ u ON u.User_userId = a.Apply_respondentId INNER JOIN %@ an ON an.Animal_animalId = a.Apply_animalId WHERE a.Apply_applicantId='%@' ORDER BY a.Apply_createTime DESC LIMIT %ld OFFSET (%ld - 1) * %ld", TABLE_NAME_APPLY, TABLE_NAME_USER, TABLE_NAME_ANIMAL, userId, pageSize, pageNo, pageSize];
        
        [dao searchWithSQL:sql messageType:messageType waitUntilDone:NO];
        
        return YES;
    } else if (messageType == TPWhetherAuditDataExists) {
        NSString *userId = argument;
        if (!userId) return YES;
        [dao search:[@{
            @"respondentId": userId,
            @"applyStatus": @1
        } keyAddPrefix:TABLE_NAME_APPLY] messageType:messageType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPFetchUserAuditDatas ||
               messageType == TPFetchUserAuditMoreDatas) {
        NSDictionary *dic = argument;
        NSString *userId = [dic tp_StringObjectForKey:@"userId"];
        NSInteger pageNo = [dic tp_IntegerObjectForKey:@"pageNo"];
        NSInteger pageSize = [dic tp_IntegerObjectForKey:@"pageSize"];
        
        NSString *sql = [NSString stringWithFormat:@"SELECT a.*, u.*, an.* FROM %@ a INNER JOIN %@ u ON u.User_userId = a.Apply_applicantId INNER JOIN %@ an ON an.Animal_animalId = a.Apply_animalId WHERE a.Apply_respondentId='%@' ORDER BY a.Apply_createTime DESC LIMIT %ld OFFSET (%ld - 1) * %ld", TABLE_NAME_APPLY, TABLE_NAME_USER, TABLE_NAME_ANIMAL, userId, pageSize, pageNo, pageSize];
        
        [dao searchWithSQL:sql messageType:messageType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPUserCancelApplication) { // 取消申请
        NSString *applyId = argument;
        [dao deleteByParam:[@{
            @"applyId": applyId
        } keyAddPrefix:TABLE_NAME_APPLY] messageType:messageType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPUserAgreedToApplication ||
               messageType == TPUserRejectedApplication) { // 同意/拒绝 申请
        NSDictionary *dic = argument;
        NSString *applyId = [dic tp_StringObjectForKey:@"applyId"];
        [dao update:[dic keyAddPrefix:TABLE_NAME_APPLY] ByPrimeKeyValue:applyId messageType:messageType waitUntilDone:NO];
        return YES;
    }
    return NO;
}
@end
