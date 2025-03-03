//
//  TPLogModule.m
//  Helper
//
//  Created by Topredator on 2025/2/19.
//

#import "TPLogModule.h"

/// 日志表
#define CREATE_TABLE_LOG   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_LOG                \
"("                                             \
" Log_logId"             " TEXT PRIMARY KEY,"        \
" Log_type"           " INTEGER default 0,"                     \
" Log_createTime"          " TEXT,"                    \
" Log_userId"           " TEXT,"                     \
" Log_applicantId"           " TEXT,"                     \
" Log_animalId"           " TEXT,"                     \
" Log_url"         " TEXT,"                     \
" Log_content"      " TEXT,"                     \
" Log_image"         " TEXT,"                    \
")"



@implementation TPLogModule
+ (void)updateDBOnLaunching:(FMDatabase *)db {
    [db executeUpdate:CREATE_TABLE_LOG];
}
+ (BOOL)handleTaskMessage:(TPDBTaskMessage *)msg {
    return NO;
}
@end
