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
    TPApplyToAdmin = 400000,
    /// 当前用户已申请 等待中
    TPApplyToAdminWaiting,
    /// 用户申请领养
    TPApplyToAdoptAnimal,
    /// 获取申请列表
    TPFetchApplyList,
};


@interface TPApplyModule : NSObject <TPDBModuleProtocol>

@end


