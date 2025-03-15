//
//  AppDelegate+TPDatabase.m
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import "AppDelegate+TPDatabase.h"
#import "TPUserModule.h"
#import "TPApplyModule.h"
#import "TPAnimalModule.h"
#import "TPDiaryModule.h"
#import "TPPublishModule.h"
#import "TPCollectModule.h"
#import "TPDonateModule.h"
#import "TPAddressModule.h"
@implementation AppDelegate (TPDatabase)
- (void)tp_setupDatabase {
    
    TPDatabaseConfig *config = [TPDatabaseConfig configDBName:@"helper.db" version:@"1.0"];
    TPDBManager.moduleArray = @[
        TPUserModule.class,
        TPAnimalModule.class,
        TPApplyModule.class,
        TPDiaryModule.class,
        TPPublishModule.class,
        TPCollectModule.class,
        TPDonateModule.class,
        TPAddressModule.class
    ];
    [TPDBManager setConfiguration:config];
}
- (void)tp_initCustomInfo {
    /// 注册超级管理员
    TPUserModel *model = [TPUserModel userAccount:@"15238272309" pwd:@"123456" name:@"Dexterly" idCard:@"410422199501061174" type:TPUserTypeSuperManager];
    [TPDBRouter sendTaskMessage:TPUserModuleRegister argument:[model tp_modelToJSONObject]];
    
    /// 注册普通管理员
    TPUserModel *managerModel = [TPUserModel userAccount:@"15993555212" pwd:@"123456" name:@"Topredator" idCard:@"410422199501060038" type:TPUserTypeManager];
    
    [TPDBRouter sendTaskMessage:TPUserModuleRegister argument:[managerModel tp_modelToJSONObject]];
    TPBaseDao *categoryDao = [TPBaseDao daoWithTableName:TABLE_NAME_DONATE_CATEGORY];
    [categoryDao save:@[@{
        @"categoryId": @0,
        @"name": @"医疗类"
    }, @{
        @"categoryId": @1,
        @"name": @"食品类"
    }, @{
        @"categoryId": @2,
        @"name": @"用品类"
    }] messageType:0 waitUntilDone:NO];
    TPBaseDao *itemDao = [TPBaseDao daoWithTableName:TABLE_NAME_DONATE_CATEGORY_ITEM];
    
    [itemDao save:@[
        @{
            @"itemId": @0,
            @"name": @"驱虫药",
            @"categoryId": @0
        },
        @{
            @"itemId": @1,
            @"name": @"疫苗",
            @"categoryId": @0
        },
        @{
            @"itemId": @2,
            @"name": @"消毒水",
            @"categoryId": @0
        },
        @{
            @"itemId": @3,
            @"name": @"绷带",
            @"categoryId": @0
        },
    ] messageType:0 waitUntilDone:NO];
    [itemDao save:@[
        @{
            @"itemId": @4,
            @"name": @"猫粮",
            @"categoryId": @1
        },
        @{
            @"itemId": @5,
            @"name": @"狗粮",
            @"categoryId": @1
        },
        @{
            @"itemId": @6,
            @"name": @"鱼肉罐头",
            @"categoryId": @1
        }
    ] messageType:0 waitUntilDone:NO];
    [itemDao save:@[
        @{
            @"itemId": @7,
            @"name": @"宠物窝",
            @"categoryId": @2
        },
        @{
            @"itemId": @8,
            @"name": @"垫子",
            @"categoryId": @2
        },
        @{
            @"itemId": @9,
            @"name": @"牵引绳",
            @"categoryId": @2
        },
        @{
            @"itemId": @10,
            @"name": @"猫砂",
            @"categoryId": @2
        },
        @{
            @"itemId": @11,
            @"name": @"猫砂盆",
            @"categoryId": @2
        }
    ] messageType:0 waitUntilDone:NO];
}
@end
