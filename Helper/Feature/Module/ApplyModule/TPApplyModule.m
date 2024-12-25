//
//  TPApplyModule.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPApplyModule.h"

/// 创建 申请表
#define CREATE_TABLE_APPLY   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_APPLY                \
"("                                             \
" ApplyapplyId"             " TEXT PRIMARY KEY,"        \
" Apply_userId"         " TEXT,"                     \
" Apply_adminId"         " TEXT,"                     \
" Apply_adoptId"         " TEXT,"                    \
" Apply_type"         " INTEGER,"                    \
" Apply_applyStatus"         " INTEGER default 1"                    \
")"

@implementation TPApplyModule
+ (void)updateDBOnLaunching:(FMDatabase *)db {
    [db executeUpdate:CREATE_TABLE_APPLY];
}
+ (BOOL)handleTaskMessage:(TPDBTaskMessage *)msg {
    return NO;
}
@end
