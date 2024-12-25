//
//  TPApplyModule.h
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import <Foundation/Foundation.h>


/// 申请表
#define TABLE_NAME_APPLY  @"Apply_"

typedef NS_ENUM(NSUInteger, TPApplyModuleMessageType) {
    /// 用户申请管理员
    TPApplyModuleAdmin = 400000,
    /// 用户申请领养
    TPApplyModuleAdoptAnimal,
};


@interface TPApplyModule : NSObject <TPDBModuleProtocol>

@end


