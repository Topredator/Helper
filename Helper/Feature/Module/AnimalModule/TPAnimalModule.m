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
" Animal_vaccine"         " INTEGER default 0,"                    \
" Animal_status"         " INTEGER default 0,"                    \
" Animal_userId"         " TEXT"                    \ 
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
    TPAdoptDao *adoptDao = [TPAdoptDao daoWithTableName:TABLE_NAME_ADOPT];
    if (messageType == TPAnimalModuleRegist) { // 注册
        TPAnimalDao *animalDao = [TPAnimalDao daoWithTableName:TABLE_NAME_ANIMAL];
        [animalDao save:argument messageType:messageType waitUntilDone:NO igoner:YES];
        return YES;
    } else if (messageType == TPAnimalModulePublicAdopt) { // 发布领养
        [adoptDao save:argument messageType:messageType waitUntilDone:NO igoner:YES];
        return YES;
    } else if (messageType == TPFetchAdoptDatas ||
               messageType == TPFetchAdoptMoreDatas) { // 获取领养数据
        NSDictionary *dic = argument;
        NSInteger type = [dic tp_IntegerObjectForKey:@"type"];
        NSInteger pageNo = [dic tp_IntegerObjectForKey:@"pageNo"];
        NSInteger pageSize = [dic tp_IntegerObjectForKey:@"pageSize"];
        
        NSString *condition = @"";
        if (type == 0) { // 全部
            condition = @"0, 1, 2";
        } else if (type == 1) { // 猫
            condition = @"0";
        } else if (type == 2) { // 狗
            condition = @"1";
        }
        
        NSString *sql = [NSString stringWithFormat:@"SELECT a.*, an.*, u.* FROM %@ a INNER JOIN %@ an ON a.Adopt_animalId = an.Animal_animalId INNER JOIN %@ u ON a.Adopt_publisherId = u.User_userId WHERE an.Animal_category IN (%@) ORDER BY a.Adopt_createTime DESC LIMIT %ld OFFSET (%ld - 1) * %ld", TABLE_NAME_ADOPT, TABLE_NAME_ANIMAL, TABLE_NAME_USER, condition, pageSize, pageNo, pageSize];
        
        NSInteger msgType = TPFetchAllAdoptDatas;
        if (messageType == TPFetchAdoptDatas) {
            if (type == 0) {
                msgType = TPFetchAllAdoptDatas;
            } else if (type == 1) {
                msgType = TPFetchCatAdoptDatas;
            } else {
                msgType = TPFetchDogAdoptDatas;
            }
        } else {
            if (type == 0) {
                msgType = TPFetchAllAdoptMoreDatas;
            } else if (type == 1) {
                msgType = TPFetchCatAdoptMoreDatas;
            } else {
                msgType = TPFetchDogAdoptMoreDatas;
            }
        }
        [adoptDao searchWithSQL:sql messageType:msgType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPAnimalModuleFetchUserAnimal ||
               messageType == TPAnimalModuleFetchUserAnimalDatas) {
        NSDictionary *dic = argument;
        NSString *userId = [dic tp_StringObjectForKey:@"userId"];
        NSInteger pageNo = [dic tp_IntegerObjectForKey:@"pageNo"];
        NSInteger pageSize = [dic tp_IntegerObjectForKey:@"pageSize"];
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE Animal_userId='%@' ORDER BY Animal_createTime DESC LIMIT %ld OFFSET (%ld - 1) * %ld",  TABLE_NAME_ANIMAL, userId, pageSize, pageNo, pageSize];
        TPBaseDao *dao = [TPBaseDao daoWithTableName:TABLE_NAME_ANIMAL];
        [dao searchWithSQL:sql messageType:messageType waitUntilDone:NO];
    } else if (messageType == TPAnimalDeleteInfo) {
        NSString *animalId = argument;
        TPBaseDao *dao = [TPBaseDao daoWithTableName:TABLE_NAME_ANIMAL];
        [dao deleteByPrimeKey:animalId messageType:messageType waitUntilDone:NO];
        return YES;
    }
//    else if (messageType == TPHomeBannerDatas) { // 首页banner
//        NSString *sql = [NSString stringWithFormat:@"SELECT a.*, an.*, u.* FROM %@ a INNER JOIN %@ an ON a.Adopt_animalId = an.Animal_animalId INNER JOIN %@ u ON a.Adopt_publisherId = u.User_userId WHERE a.Adopt_beAdopted = 0 ORDER BY a.Adopt_createTime DESC LIMIT 5", TABLE_NAME_ADOPT, TABLE_NAME_ANIMAL, TABLE_NAME_USER];
//        [adoptDao searchWithSQL:sql messageType:messageType waitUntilDone:NO];
//        return YES;
//    }
    return NO;
}
@end
