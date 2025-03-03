//
//  TPDailyModule.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPDiaryModule.h"
#import "TPDiaryDao.h"


/// 创建 申请表
#define CREATE_TABLE_DIARY   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_DIARY                \
"("                                             \
" Diary_diaryId"             " TEXT PRIMARY KEY,"        \
" Diary_userId"         " TEXT,"                     \
" Diary_title"         " TEXT,"                     \
" Diary_content"         " TEXT,"                    \
" Diary_image"         " TEXT,"                    \
" Diary_createTime"         " TEXT"                    \
")"

@implementation TPDiaryModule
+ (BOOL)handleTaskMessage:(TPDBTaskMessage *)msg {
    NSInteger messageType = msg.taskMsgType;
    id argument = msg.argument;
    TPBaseDao *dao = [TPDiaryDao daoWithTableName:TABLE_NAME_DIARY];
    if (messageType == TPDiaryModulePublic) {
        [dao save:argument messageType:messageType waitUntilDone:NO igoner:YES];
        return YES;
    } else if (messageType == TPDiaryFetchDatas || messageType == TPDiaryFetchMoreDatas) {
        NSInteger pageNo = [argument[@"pageNo"] integerValue];
        NSInteger pageSize = [argument[@"pageSize"] integerValue];
        NSString *sql = [NSString stringWithFormat:@"SELECT d.*, u.* FROM Diary_ AS d INNER JOIN User_ AS u ON d.Diary_userId = u.User_userId ORDER BY d.Diary_createTime DESC LIMIT %ld OFFSET (%ld - 1) * %ld", pageSize, pageNo, pageSize];
        [dao searchWithSQL:sql messageType:messageType waitUntilDone:NO];
        return YES;
    }
    return NO;
}
@end
