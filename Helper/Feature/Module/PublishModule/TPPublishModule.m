//
//  TPPublishModule.m
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import "TPPublishModule.h"

#import "TPPublishDao.h"

/// 发布表
#define CREATE_TABLE_PUBLISH   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_PUBLISH                \
"("                                             \
" Publish_publishId"             " TEXT PRIMARY KEY,"        \
" Publish_type"           " INTEGER default 0,"                     \
" Publish_createTime"          " TEXT,"                    \
" Publish_userId"           " TEXT,"                     \
" Publish_animalId"           " TEXT,"                     \
" Publish_title"         " TEXT,"                     \
" Publish_url"         " TEXT,"                     \
" Publish_content"      " TEXT,"                     \
" Publish_image"         " TEXT,"                    \
" Publish_animals"          " TEXT," \
" Publish_detailImages"    " TEXT" \
")"


@implementation TPPublishModule
+ (void)updateDBOnLaunching:(FMDatabase *)db {
    [db executeUpdate:CREATE_TABLE_PUBLISH];
}
+ (BOOL)handleTaskMessage:(TPDBTaskMessage *)msg {
    NSInteger messageType = msg.taskMsgType;
    id argument = msg.argument;
    TPPublishDao *dao = [TPPublishDao daoWithTableName:TABLE_NAME_PUBLISH];
    if (messageType == TPPublishModulePublishMessage) { // 发布消息
        [dao save:argument messageType:messageType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPHomeBannerDatas) { // 首页banner
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE Publish_type = %d OR Publish_type = %d ORDER BY Publish_createTime DESC", TABLE_NAME_PUBLISH, 0, 1];
        [dao searchWithSQL:sql messageType:messageType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPPublishDiaryDatas ||
               messageType == TPPublishDiaryMoreDatas) { // 日记数据
        NSDictionary *dic = (NSDictionary *)argument;
        NSInteger pageNo = [dic tp_IntegerObjectForKey:@"pageNo"];
        NSInteger pageSize = [dic tp_IntegerObjectForKey:@"pageSize"];
        NSString *sql = [NSString stringWithFormat:@"SELECT p.*, u.* FROM %@ AS p INNER JOIN %@ AS u ON u.User_userId = p.Publish_userId WHERE p.Publish_type = %d ORDER BY Publish_createTime DESC LIMIT %ld OFFSET (%ld - 1) * %ld", TABLE_NAME_PUBLISH, TABLE_NAME_USER, 2, pageSize, pageNo, pageSize];
        [dao searchWithSQL:sql messageType:messageType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPPublishAnimalDatas ||
               messageType == TPPublishAnimalMoreDatas ||
               messageType == TPFetchBeRescuedAnimalDatas ||
               messageType == TPFetchBeRescuedAnimalMoreDatas ||
               messageType == TPFetchInRecoveryAnimalDatas ||
               messageType == TPFetchInRecoveryAnimalMoreDatas) { // 动物数据
        NSDictionary *dic = (NSDictionary *)argument;
        NSInteger pageNo = [dic tp_IntegerObjectForKey:@"pageNo"];
        NSInteger pageSize = [dic tp_IntegerObjectForKey:@"pageSize"];
        NSInteger type = [dic tp_IntegerObjectForKey:@"type"];
        
        NSString *condition = @"";
        if (type == 0) { // 全部
            condition = @"3, 4, 5";
        } else if (type == 1) { // 猫
            condition = @"3";
        } else if (type == 2) { // 狗
            condition = @"4";
        } else if (type == 3) {
            condition = @"5";
        }
    
        NSString *sql = [NSString stringWithFormat:@"SELECT p.*, a.*, u.* FROM %@ p INNER JOIN %@ a ON a.Animal_animalId = p.Publish_animalId INNER JOIN %@ u ON p.Publish_userId = u.User_userId WHERE p.Publish_type IN (%@) ORDER BY p.Publish_createTime DESC LIMIT %ld OFFSET (%ld - 1) * %ld", TABLE_NAME_PUBLISH, TABLE_NAME_ANIMAL, TABLE_NAME_USER, condition, pageSize, pageNo, pageSize];
        
        NSInteger msgType = TPFetchAllAnimalDatas;
        if (messageType == TPPublishAnimalDatas) {
            if (type == 0) {
                msgType = TPFetchAllAnimalDatas;
            } else if (type == 1) {
                msgType = TPFetchBeRescuedAnimalDatas;
            } else if (type == 2) {
                msgType = TPFetchInRecoveryAnimalDatas;
            } else {
                msgType = TPFetchPendingAdoptAnimalDatas;
            }
        } else {
            if (type == 0) {
                msgType = TPFetchAllAnimalMoreDatas;
            } else if (type == 1) {
                msgType = TPFetchBeRescuedAnimalMoreDatas;
            } else if (type == 2) {
                msgType = TPFetchInRecoveryAnimalMoreDatas;
            } else {
                msgType = TPFetchPendingAdoptAnimalMoreDatas;
            }
        }
        
        [dao searchWithSQL:sql messageType:msgType waitUntilDone:NO];
        return YES;
    }
    return NO;
}
@end
