//
//  TPCollectModule.m
//  Helper
//
//  Created by Topredator on 2025/3/3.
//

#import "TPCollectModule.h"

/// 发布表
#define CREATE_TABLE_COLLECT   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_COLLECT                \
"("                                             \
" Collect_collectId"             " TEXT PRIMARY KEY,"        \
" Collect_animalId"           " TEXT,"                     \
" Collect_createTime"          " TEXT,"                    \
" Collect_userId"           " TEXT"                     \
")"


@implementation TPCollectModule
+ (void)updateDBOnLaunching:(FMDatabase *)db {
    [db executeUpdate:CREATE_TABLE_COLLECT];
}
+ (BOOL)handleTaskMessage:(TPDBTaskMessage *)msg {
    NSInteger messageType = msg.taskMsgType;
    id argument = msg.argument;
    TPBaseDao *dao = [TPBaseDao daoWithTableName:TABLE_NAME_COLLECT];
    if (messageType == TPCollectionModuleAddCollect) { // 收藏
        NSDictionary *dic = (NSDictionary *)argument;
        [dao save:dic messageType:messageType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPCollectMododuleRemoveCollect) { // 删除收藏
        NSString *animalId = (NSString *)argument;
        if (!animalId) return NO;
        [dao deleteByParam:@{
            @"Collect_animalId": animalId
        } messageType:messageType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPCollectModuleQueryData) { // 查询收藏数据
        NSString *animalId = (NSString *)argument;
        if (!animalId) return NO;
        [dao search:@{
            @"Collect_animalId": animalId
        } messageType:messageType waitUntilDone:NO];
        return YES;
        
    } else if (messageType == TPCollectModuleFetchUserCollectDatas ||
               messageType == TPCollectModuleFetchUserCollectMoreDatas) {
        NSDictionary *dic = (NSDictionary *)argument;
        NSInteger pageNo = [dic tp_IntegerObjectForKey:@"pageNo"];
        NSInteger pageSize = [dic tp_IntegerObjectForKey:@"pageSize"];
        NSString *userId = [dic tp_StringObjectForKey:@"userId"];
        NSString *sql = [NSString stringWithFormat:@"SELECT c.*, a.*, u.* FROM %@ c INNER JOIN %@ a ON a.Animal_animalId = c.Collect_animalId INNER JOIN %@ u ON c.Collect_userId = u.User_userId WHERE c.Collect_userId = '%@' ORDER BY c.Collect_createTime DESC LIMIT %ld OFFSET (%ld - 1) * %ld", TABLE_NAME_COLLECT, TABLE_NAME_ANIMAL, TABLE_NAME_USER, userId, pageSize, pageNo, pageSize];
        [dao searchWithSQL:sql messageType:messageType waitUntilDone:NO];
        
        return YES;
    }
    return NO;
}
@end
