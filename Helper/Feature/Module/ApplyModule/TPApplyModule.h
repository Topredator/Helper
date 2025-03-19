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
    /// 用户申请领养
    TPApplyToAdoptAnimal,
    /// 当前用户已申请 等待中
    TPApplyToAdminWaiting,
    /// 是否存在审核数据
    TPWhetherAuditDataExists,
    /// 当前用户需要审批的数据
    TPFetchUserAuditDatas,
    TPFetchUserAuditMoreDatas,
    /// 获取用户申请数据
    TPFetchUserApplyDatas,
    TPFetchUserApplyMoreDatas,
    /// 用户取消申请
    TPUserCancelApplication,
    /// 用户同意了申请
    TPUserAgreedToApplication,
    /// 用户拒接了领养申请
    TPUserRejectedApplication
};


@interface TPApplyModule : NSObject <TPDBModuleProtocol>

@end


