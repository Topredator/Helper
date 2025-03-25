//
//  TPAddressModule.m
//  Helper
//
//  Created by Topredator on 2025/3/5.
//

#import "TPAddressModule.h"
#import "TPAddressModel.h"

#define CREATE_TABLE_ADDRESS   @"CREATE TABLE IF NOT EXISTS "  TABLE_NAME_ADDRESS                \
"("                                             \
" Address_addressId"             " TEXT PRIMARY KEY,"        \
" Address_name"          " TEXT,"                    \
" Address_phone"          " TEXT,"                    \
" Address_detailAddress"           " TEXT,"                     \
" Address_createTime"          " TEXT,"                    \
" Address_isDefault"           " INTEGER DEFAULT (0),"                     \
" Address_userId"           " TEXT"                     \
")"


@implementation TPAddressModule
+ (void)updateDBOnLaunching:(FMDatabase *)db {
    [db executeUpdate:CREATE_TABLE_ADDRESS];
}
+ (BOOL)handleTaskMessage:(TPDBTaskMessage *)msg {
    NSInteger messageType = msg.taskMsgType;
    id argument = msg.argument;
    TPBaseDao *dao = [TPBaseDao daoWithTableName:TABLE_NAME_ADDRESS];
    if (messageType == TPAddressFetchUserInfo) { // 查询用户地址
        NSString *userId = (NSString *)argument;
        if (userId) {
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ LEFT JOIN %@ ON User_userId=Address_userId WHERE Address_userId='%@'", TABLE_NAME_ADDRESS, TABLE_NAME_USER, userId];
            [dao searchWithSQL:sql messageType:messageType waitUntilDone:NO];
        }
        
        return YES;
    } else if (messageType == TPAddressFetchUserDefaultAddress) { // 查询用户默认地址
        NSString *userId = (NSString *)argument;
        if (userId) {
            NSArray *addresses = [dao search:@{
                @"Address_userId": userId,
                @"Address_isDefault": @1
            } messageType:messageType waitUntilDone:YES];
            NSArray *mapAddresses = ASTMap(addresses, ^id(NSDictionary * obj) {
                return [obj keyRemovePrefix:TABLE_NAME_ADDRESS];
            });
            NSArray *addressModels = [NSArray tp_modelArrayWithClass:TPAddressModel.class json:mapAddresses];
            msg.result = addressModels.count ? addressModels.firstObject : nil;
        }
        return YES;
    } else if (messageType == TPAddressAddNewUserAddress) { // 新增用户地址
        NSDictionary *dic = (NSDictionary *)argument;
        NSString *userId = [dic tp_StringObjectForKey:@"userId"];
        if (!userId) {
            return YES;
        }
        NSArray *adds = [dao search:@{
            @"Address_userId": userId
        } messageType:0 waitUntilDone:YES];
        NSMutableDictionary *mDic = dic.mutableCopy;
        if (!adds.count) {
            [mDic setValue:@1 forKey:@"Address_isDefault"];
        }
        [dao save:mDic.copy messageType:messageType waitUntilDone:NO];
        return YES;
    } else if (messageType == TPAddressEditUserAddress) { // 编辑地址
        NSDictionary *dic = (NSDictionary *)argument;
        NSString *userId = [dic tp_StringObjectForKey:@"userId"];
        NSInteger isDefault = [dic tp_IntegerObjectForKey:@"isDefault"];
        if (isDefault == 1) {
            NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET Address_isDefault=0 WHERE Address_userId='%@' AND Address_isDefault=1", TABLE_NAME_ADDRESS, userId];
            // 默认地址修改
            [dao update:sql parameter:nil messageType:0 waitUntilDone:YES];
            // 插入数据
            [dao save:dic messageType:messageType waitUntilDone:NO];
        } else {
            // 先保存
            [dao save:dic messageType:messageType waitUntilDone:YES];
            // 查询是否有默认地址数据
            NSArray *arr = [dao search:@{
                @"Address_userId": userId,
                @"Address_isDefault": @1
            } messageType:messageType waitUntilDone:YES];
            if (arr.count) {
                [TPDBRouter sendMessageToRoutes:messageType result:0 argument:nil];
            } else {
                NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET Address_isDefault=1 WHERE Address_addressId=(SELECT Address_addressId FROM %@ ORDER BY Address_createTime DESC LIMIT 1)", TABLE_NAME_ADDRESS, TABLE_NAME_ADDRESS];
                [dao update:sql parameter:nil messageType:messageType waitUntilDone:NO];
            }
        }
        return YES;
    } else if (messageType == TPAddressDeleteUserAddress) { // 删除用户地址
        NSString *addressId = (NSString *)argument;
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE Address_addressId='%@'", TABLE_NAME_ADDRESS, addressId];
        [dao update:sql parameter:nil messageType:0 waitUntilDone:NO];
        // 查询是否有默认地址数据
        NSArray *arr = [dao search:@{
            @"Address_userId": TPUserManager.manager.user.userId,
            @"Address_isDefault": @1
        } messageType:messageType waitUntilDone:YES];
        if (arr.count) {
            [TPDBRouter sendMessageToRoutes:messageType result:0 argument:nil];
        } else {
            NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET Address_isDefault=1 WHERE Address_addressId=(SELECT Address_addressId FROM %@ ORDER BY Address_createTime DESC LIMIT 1)", TABLE_NAME_ADDRESS, TABLE_NAME_ADDRESS];
            [dao update:sql parameter:nil messageType:messageType waitUntilDone:NO];
        }
        return YES;
    } else if (messageType == TPAddressSetUserDefaultAddress) { // 设置用户默认地址
        
    }
    return NO;
}
@end
