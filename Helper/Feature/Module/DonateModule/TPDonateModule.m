//
//  TPDonateModule.m
//  Helper
//
//  Created by Topredator on 2025/3/5.
//

#import "TPDonateModule.h"
#import "TPDonateModel.h"
/// donate 表字段
#define DONATE_ID @"" TABLE_NAME_DONATE"donateId"
#define DONATE_DONATOR_ID @"" TABLE_NAME_DONATE"donaterId"
#define DONATE_DONEE_ID @"" TABLE_NAME_DONATE"doneeId"
#define DONATE_ANIMAL_ID @"" TABLE_NAME_DONATE"animalId"
#define DONATE_CREATE_TIME @"" TABLE_NAME_DONATE"createTime"
#define DONATE_EXPRESS_NUMBER @"" TABLE_NAME_DONATE"expressNumber"
/// category 表字段
#define DONATE_CATEGORY_ID @"" TABLE_NAME_DONATE_CATEGORY"categoryId"
#define DONATE_CATEGORY_NAME @"" TABLE_NAME_DONATE_CATEGORY"categoryName"

/// Item 表字段
#define DONATE_CATEGORY_ITEM_ID  @"" TABLE_NAME_DONATE_CATEGORY_ITEM"itemId"
#define DONATE_CATEGORY_ITEM_NAME  @"" TABLE_NAME_DONATE_CATEGORY_ITEM"itemName"
#define DONATE_CATEGORY_ITEM_CATEGORY_ID  @"" TABLE_NAME_DONATE_CATEGORY_ITEM"categoryId"


/// donate_detail 表字段
#define DONATE_DETAIL_ID @"" TABLE_NAME_DONATE_DETAIL"detailId"
#define DONATE_DETAIL_DONATE_ID @"" TABLE_NAME_DONATE_DETAIL"donateId"
#define DONATE_DETAIL_CATEGORY_ID @"" TABLE_NAME_DONATE_DETAIL"categoryId"
#define DONATE_DETAIL_CATEGORY_NAME @"" TABLE_NAME_DONATE_DETAIL"categoryName"
#define DONATE_DETAIL_ITEM_ID @"" TABLE_NAME_DONATE_DETAIL"itemId"
#define DONATE_DETAIL_ITEM_NAME @"" TABLE_NAME_DONATE_DETAIL"itemName"
#define DONATE_DETAIL_ITEM_QUANTITY @"" TABLE_NAME_DONATE_DETAIL"quantity"



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
DONATE_DONATOR_ID           " TEXT,"                     \
DONATE_DONEE_ID             " TEXT,"                    \
DONATE_ANIMAL_ID           " TEXT,"                     \
DONATE_CREATE_TIME           " TEXT,"                     \
DONATE_EXPRESS_NUMBER           " TEXT"                     \
")"
/// 创建捐赠 详情表
#define CREATE_TABLE_DONATE_DETAIL  @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_DONATE_DETAIL                \
"("                                             \
DONATE_DETAIL_ID             " INTEGER PRIMARY KEY AUTOINCREMENT,"        \
DONATE_DETAIL_DONATE_ID           " TEXT,"                     \
DONATE_DETAIL_CATEGORY_ID      " INTEGER DEFAULT (0) NOT NULL," \
DONATE_DETAIL_CATEGORY_NAME      " TEXT," \
DONATE_DETAIL_ITEM_ID           " INTEGER DEFAULT (0) NOT NULL,"                     \
DONATE_DETAIL_ITEM_NAME           " TEXT,"                     \
DONATE_DETAIL_ITEM_QUANTITY           " INTEGER DEFAULT (1) NOT NULL"                     \
")"


@implementation TPDonateModule
+ (void)updateDBOnLaunching:(FMDatabase *)db {
    [db executeUpdate:CREATE_TABLE_DONATE];
    [db executeUpdate:CREATE_TABLE_DONATE_DETAIL];
    [db executeUpdate:CREATE_TABLE_DONATE_CATEGORY];
    [db executeUpdate:CREATE_TABLE_DONATE_CATEGORY_ITEM];
}
+ (BOOL)handleTaskMessage:(TPDBTaskMessage *)msg {
    NSInteger messageType = msg.taskMsgType;
    id argument = msg.argument;
    
    if (messageType == TPDonateFetchAllCategories) {
        TPBaseDao *dao = [TPBaseDao daoWithTableName:TABLE_NAME_DONATE_CATEGORY];
        NSString *sql = [NSString stringWithFormat:@"SELECT c.%@ AS categoryId, c.%@ AS categoryName FROM %@ c", DONATE_CATEGORY_ID, DONATE_CATEGORY_NAME, TABLE_NAME_DONATE_CATEGORY];
        NSArray *categories = [dao searchWithSQL:sql messageType:0 waitUntilDone:YES];
        NSMutableArray *tempArray = @[].mutableCopy;
        for (NSDictionary *dic in categories) {
            NSInteger categoryId = [dic tp_IntegerObjectForKey:@"categoryId"];
            NSString *itemSql = [NSString stringWithFormat:@"SELECT i.%@ AS itemId, i.%@ AS itemName, i.%@ AS categoryId FROM %@ i WHERE i.%@ = %ld", DONATE_CATEGORY_ITEM_ID, DONATE_CATEGORY_ITEM_NAME, DONATE_CATEGORY_ITEM_CATEGORY_ID, TABLE_NAME_DONATE_CATEGORY_ITEM, DONATE_CATEGORY_ITEM_CATEGORY_ID, categoryId];
            NSArray *items = [dao searchWithSQL:itemSql messageType:0 waitUntilDone:YES];
            NSMutableDictionary *mDic = dic.mutableCopy;
            mDic[@"items"] = items;
            [tempArray addObject:mDic];
        }
        [TPDBRouter sendMessageToRoutes:messageType result:0 argument:tempArray.copy];
        return YES;
    } else if (messageType == TPDonatePetDonation) {
        TPDonateOperate *operate = argument;
        NSMutableArray *sqls = @[].mutableCopy;
        for (TPDonateCategoryModel *categoryModel in operate.categorys) {
            for (TPDonateItemModel *itemModel in categoryModel.items) {
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO Donate_detail_ (Donate_detail_donateId, Donate_detail_categoryId, Donate_detail_categoryName, Donate_detail_itemId, Donate_detail_itemName, Donate_detail_quantity) VALUES ('%@', %ld, '%@', %ld, '%@', %ld)", operate.donate.donateId, categoryModel.categoryId, categoryModel.categoryName, itemModel.itemId, itemModel.itemName, itemModel.quantity];
                [sqls addObject:sql];
            }
        }
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO Donate_ (Donate_donateId, Donate_donaterId, Donate_doneeId, Donate_animalId, Donate_createTime, Donate_expressNumber) VALUES ('%@', '%@', '%@', '%@', '%@', '%@')", operate.donate.donateId, operate.donate.donaterId, operate.donate.doneeId, operate.donate.animalId, operate.donate.createTime, operate.donate.expressNumber];
        [sqls addObject:sql];
        TPBaseDao *dao = [TPBaseDao daoWithTableName:TABLE_NAME_DONATE];
        [dao updateTransaction:sqls messageType:messageType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPDonateFetchUserDonates ||
               messageType == TPDonateFetchUserMoreDonates) { // 用户所有捐赠
        NSArray *array = [TPDBRouter syncSendTaskMessage:TPDonateFetchCommonDonates argument:argument];
        NSMutableArray *operates = @[].mutableCopy;
        for (NSDictionary *dic in array) {
            TPDonateModel *donate = [TPDonateModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_DONATE]];
            TPUserModel *donee = [TPUserModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_USER]];
            TPAnimalModel *animal = [TPAnimalModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_ANIMAL]];
            donate.donee = donee;
            donate.animal = animal;
            
            /// 获取category 数组
            TPBaseDao *dao = [TPBaseDao daoWithTableName:TABLE_NAME_DONATE_DETAIL];
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Donate_detail_ WHERE Donate_detail_donateId = '%@'", donate.donateId];
            NSArray *categoryList = [dao searchWithSQL:sql messageType:0 waitUntilDone:YES];
            NSArray *categories = ASTMap(categoryList, ^id(NSDictionary * obj, NSUInteger idx) {
                return [obj keyRemovePrefix:TABLE_NAME_DONATE_DETAIL];
            });
            
            NSMutableArray *tempCategories = @[].mutableCopy;
            NSMutableArray *categoryIds = @[].mutableCopy;
            for (NSDictionary *dic in categories) {
                NSNumber *categoryId = [dic tp_NumberObjectForKey:@"categoryId"];
                if ([categoryIds containsObject:categoryId]) {
                    continue;
                }
                TPDonateCategoryModel *categoryModel = [TPDonateCategoryModel tp_modelWithDictionary:dic];
                [tempCategories addObject:categoryModel];
                [categoryIds addObject:@(categoryModel.categoryId)];
            }
            for (TPDonateCategoryModel *model in tempCategories) {
                NSMutableArray *tempItems = @[].mutableCopy;
                for (NSDictionary *dic in categories) {
                    NSInteger categoryId = [dic tp_IntegerObjectForKey:@"categoryId"];
                    if (model.categoryId == categoryId) {
                        TPDonateItemModel *itemModel = [TPDonateItemModel tp_modelWithDictionary:dic];
                        [tempItems addObject:itemModel];
                    }
                }
                model.items = tempItems.copy;
            }
            TPDonateOperate *operate = [TPDonateOperate new];
            operate.donate = donate;
            operate.categorys = tempCategories.copy;
            [operates addObject:operate];
        }
        [TPDBRouter sendMessageToRoutes:messageType result:0 argument:operates];
        return YES;
    } else if (messageType == TPDonateFetchCommonDonates) {
        NSDictionary *dic = argument;
        NSString *userId = [dic tp_StringObjectForKey:@"userId"];
        NSInteger pageSize = [dic tp_IntegerObjectForKey:@"pageSize"];
        NSInteger pageNo = [dic tp_IntegerObjectForKey:@"pageNo"];
        NSString *sql = [NSString stringWithFormat:@"SELECT d.*, a.*, u.* FROM Donate_ d INNER JOIN Animal_ a ON a.Animal_animalId = d.Donate_animalId INNER JOIN User_ u ON d.Donate_doneeId = u.User_userId  WHERE Donate_donaterId = '%@' ORDER BY d.Donate_createTime DESC LIMIT %ld OFFSET (%ld - 1) * %ld", userId, pageSize, pageNo, pageSize];
        TPBaseDao *dao = [TPBaseDao daoWithTableName:TABLE_NAME_DONATE];
        msg.result = [dao searchWithSQL:sql messageType:messageType waitUntilDone:YES];
        
        return YES;
    } else if (messageType == TPDonateFetchAllDonates ||
               messageType == TPDonateFetchAllMoreDonates) {
        NSDictionary *dic = argument;
        NSInteger pageSize = [dic tp_IntegerObjectForKey:@"pageSize"];
        NSInteger pageNo = [dic tp_IntegerObjectForKey:@"pageNo"];
        NSString *sql = [NSString stringWithFormat:@"SELECT d.*, a.*, u.* FROM Donate_ d INNER JOIN Animal_ a ON a.Animal_animalId = d.Donate_animalId INNER JOIN User_ u ON d.Donate_doneeId = u.User_userId  ORDER BY d.Donate_createTime DESC LIMIT %ld OFFSET (%ld - 1) * %ld", pageSize, pageNo, pageSize];
        TPBaseDao *dao = [TPBaseDao daoWithTableName:TABLE_NAME_DONATE];
        NSArray *array = [dao searchWithSQL:sql messageType:0 waitUntilDone:YES];
        NSMutableArray *operates = @[].mutableCopy;
        for (NSDictionary *dic in array) {
            TPDonateModel *donate = [TPDonateModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_DONATE]];
            TPUserModel *donee = [TPUserModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_USER]];
            TPAnimalModel *animal = [TPAnimalModel tp_modelWithDictionary:[dic keyRemovePrefix:TABLE_NAME_ANIMAL]];
            donate.donee = donee;
            donate.animal = animal;
            TPBaseDao *userDao = [TPBaseDao daoWithTableName:TABLE_NAME_USER];
            NSArray *userList = [userDao search:[@{
                @"userId": donate.donaterId ?: @""
            } keyAddPrefix:TABLE_NAME_USER] messageType:0 waitUntilDone:YES];
            if (userList.count) {
                TPUserModel *donater = [TPUserModel tp_modelWithDictionary:[(NSDictionary *)userList.firstObject keyRemovePrefix:TABLE_NAME_USER]];
                donate.donater = donater;
            }
            
            /// 获取category 数组
            TPBaseDao *dao = [TPBaseDao daoWithTableName:TABLE_NAME_DONATE_DETAIL];
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Donate_detail_ WHERE Donate_detail_donateId = '%@'", donate.donateId];
            NSArray *categoryList = [dao searchWithSQL:sql messageType:0 waitUntilDone:YES];
            NSArray *categories = ASTMap(categoryList, ^id(NSDictionary * obj, NSUInteger idx) {
                return [obj keyRemovePrefix:TABLE_NAME_DONATE_DETAIL];
            });
            
            NSMutableArray *tempCategories = @[].mutableCopy;
            NSMutableArray *categoryIds = @[].mutableCopy;
            for (NSDictionary *dic in categories) {
                NSNumber *categoryId = [dic tp_NumberObjectForKey:@"categoryId"];
                if ([categoryIds containsObject:categoryId]) {
                    continue;
                }
                TPDonateCategoryModel *categoryModel = [TPDonateCategoryModel tp_modelWithDictionary:dic];
                [tempCategories addObject:categoryModel];
                [categoryIds addObject:@(categoryModel.categoryId)];
            }
            for (TPDonateCategoryModel *model in tempCategories) {
                NSMutableArray *tempItems = @[].mutableCopy;
                for (NSDictionary *dic in categories) {
                    NSInteger categoryId = [dic tp_IntegerObjectForKey:@"categoryId"];
                    if (model.categoryId == categoryId) {
                        TPDonateItemModel *itemModel = [TPDonateItemModel tp_modelWithDictionary:dic];
                        [tempItems addObject:itemModel];
                    }
                }
                model.items = tempItems.copy;
            }
            TPDonateOperate *operate = [TPDonateOperate new];
            operate.donate = donate;
            operate.categorys = tempCategories.copy;
            [operates addObject:operate];
            
        }
        [TPDBRouter sendMessageToRoutes:messageType result:0 argument:operates];
        return YES;
    }
    return NO;
}
@end
