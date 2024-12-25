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

@implementation AppDelegate (TPDatabase)
- (void)tp_setupDatabase {
    
    TPDatabaseConfig *config = [TPDatabaseConfig configDBName:@"helper.db" version:@"1.0"];
    TPDBManager.moduleArray = @[
        TPUserModule.class,
        TPAnimalModule.class,
        TPApplyModule.class,
        TPDiaryModule.class
    ];
    [TPDBManager setConfiguration:config];
}
@end
