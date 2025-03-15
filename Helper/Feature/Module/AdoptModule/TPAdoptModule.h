//
//  TPAdoptModule.h
//  Helper
//
//  Created by Topredator on 2025/3/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 领养信息类型
typedef NS_ENUM(NSInteger, TPAdoptModuleMessageType) {
    /// 申请领养
    TPAdoptApplyAdopt = 900000,
    /// 同意领养
    TPAdoptConsentToAdopt,
    /// 拒绝领养
    TPAdoptRefuseToadopt,
};


#define TABLE_NAME_ADOPT @"Adopt_"


/// 领养模块
@interface TPAdoptModule : NSObject <TPDBModuleProtocol>

@end

NS_ASSUME_NONNULL_END
