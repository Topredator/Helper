//
//  TPAnimalModule.m
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import "TPAnimalModule.h"
#import "TPAnimalDao.h"
#import "TPAdoptDao.h"


/// 创建 动物表
#define CREATE_TABLE_ANIMAL   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_ANIMAL                \
"("                                             \
" Animal_animalId"             " TEXT PRIMARY KEY,"        \
" Animal_age"           " INTEGER,"                     \
" Animal_number"         " TEXT,"                     \
" Animal_category"         " INTEGER default 0,"                    \
" Animal_name"          " TEXT,"           \
" Animal_breed"            " TEXT,"                      \
" Animal_createTime"        " TEXT,"            \
" Animal_thumbImage"        " TEXT,"            \
" Animal_coverImage"        " TEXT,"            \
" Animal_sexType"         " INTEGER default 0,"                    \
" Animal_sterilization"         " INTEGER default 0,"                    \
" Animal_deworming"         " INTEGER default 0,"                    \
" Animal_vaccine"         " INTEGER default 0"                    \
")"

/// 创建 领养表
#define CREATE_TABLE_ADOPT   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_ADOPT                \
"("                                             \
" Adopt_adoptId"             " TEXT PRIMARY KEY,"        \
" Adopt_animalId"         " TEXT,"                     \
" Adopt_beAdopted"         " INTEGER default 0,"                    \
" Adopt_publisherId"          " TEXT,"           \
" Adopt_createTime"        " TEXT,"            \
" Adopt_applyStatus"        " INTEGER default 0,"            \
" Adopt_adopterId"        " TEXT"            \
")"



@implementation TPAnimalModule
+ (void)updateDBOnLaunching:(FMDatabase *)db {
    [db executeUpdate:CREATE_TABLE_ANIMAL];
    [db executeUpdate:CREATE_TABLE_ADOPT];
}
+ (BOOL)handleTaskMessage:(TPDBTaskMessage *)msg {
    NSInteger messageType = msg.taskMsgType;
    id argument = msg.argument;
    if (messageType == TPAnimalModuleRegist) { // 注册
        TPAnimalDao *animalDao = [TPAnimalDao daoWithTableName:TABLE_NAME_ANIMAL];
        [animalDao save:argument messageType:messageType waitUntilDone:NO igoner:YES];
        return YES;
    } else if (messageType == TPAnimalModulePublicAdopt) { // 发布领养
        TPAdoptDao *adoptDao = [TPAdoptDao daoWithTableName:TABLE_NAME_ADOPT];
        [adoptDao save:argument messageType:messageType waitUntilDone:NO igoner:YES];
        return YES;
    }
    return NO;
}
@end
