//
//  TPAnimalModule.h
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import <Foundation/Foundation.h>

/// 动物表名
#define TABLE_NAME_ANIMAL  @"Animal_"
/// 领养表
#define TABLE_NAME_ADOPT  @"Adopt_"

typedef NS_ENUM(NSUInteger, TPAnimalModuleMessageType) {
    /// 动物注册
    TPAnimalModuleRegist = 300000,
    /// 管理员发布领养
    TPAnimalModulePublicAdopt,
};


@interface TPAnimalModule : NSObject <TPDBModuleProtocol>

@end


