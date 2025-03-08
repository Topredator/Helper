//
//  TPDonateModule.m
//  Helper
//
//  Created by Topredator on 2025/3/5.
//

#import "TPDonateModule.h"

/// donate 表字段
#define DONATE_ID @"" TABLE_NAME_DONATE"donateId"
#define DONATE_USER_ID @"" TABLE_NAME_DONATE"userId"
#define DONATE_ANIMAL_ID @"" TABLE_NAME_DONATE"animalId"
#define DONATE_ITEM_ID @"" TABLE_NAME_DONATE"itemId"
#define DONATE_QUANTITY @"" TABLE_NAME_DONATE"quantity"
#define DONATE_CREATE_TIME @"" TABLE_NAME_DONATE"createTime"

/// category 表字段
#define DONATE_CATEGORY_ID @"" TABLE_NAME_DONATE_CATEGORY"categoryId"
#define DONATE_CATEGORY_NAME @"" TABLE_NAME_DONATE_CATEGORY"name"

/// Item 表字段
#define DONATE_CATEGORY_ITEM_ID  @"" TABLE_NAME_DONATE_CATEGORY_ITEM"itemId"
#define DONATE_CATEGORY_ITEM_NAME  @"" TABLE_NAME_DONATE_CATEGORY_ITEM"name"
#define DONATE_CATEGORY_ITEM_CATEGORY_ID  @"" TABLE_NAME_DONATE_CATEGORY_ITEM"categoryId"

/// 创建item表
#define CREATE_TABLE_DONATE_CATEGORY_ITEM   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_DONATE_CATEGORY_ITEM                \
"("                                             \
DONATE_CATEGORY_ITEM_ID             " INTEGER PRIMARY KEY AUTOINCREMENT,"        \
DONATE_CATEGORY_ITEM_NAME           " TEXT,"                     \
DONATE_CATEGORY_ITEM_CATEGORY_ID          " INTEGER DEFAULT (0)"                    \
")"

/// 创建Category表
#define CREATE_TABLE_DONATE_CATEGORY   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_DONATE_CATEGORY                \
"("                                             \
DONATE_CATEGORY_ID             " INTEGER PRIMARY KEY AUTOINCREMENT,"        \
DONATE_CATEGORY_NAME           " TEXT"                     \
")"

/// 创建捐赠表
#define CREATE_TABLE_DONATE  @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_DONATE                \
"("                                             \
DONATE_ID             " TEXT PRIMARY KEY,"        \
DONATE_USER_ID           " TEXT,"                     \
DONATE_ANIMAL_ID           " TEXT,"                     \
DONATE_ITEM_ID           " TEXT,"                     \
DONATE_QUANTITY           " INTEGER DEFAULT (1) NOT NULL,"                     \
DONATE_CREATE_TIME           " TEXT"                     \
")"

@implementation TPDonateModule
+ (void)updateDBOnLaunching:(FMDatabase *)db {
    [db executeUpdate:CREATE_TABLE_DONATE];
    [db executeUpdate:CREATE_TABLE_DONATE_CATEGORY];
    [db executeUpdate:CREATE_TABLE_DONATE_CATEGORY_ITEM];
}
+ (BOOL)handleTaskMessage:(TPDBTaskMessage *)msg {
    NSInteger messageType = msg.taskMsgType;
    id argument = msg.argument;
    return NO;
}
@end
