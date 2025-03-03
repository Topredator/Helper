//
//  TPDailyModule.h
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import <Foundation/Foundation.h>

/// 申请表
#define TABLE_NAME_DIARY  @"Diary_"


typedef NS_ENUM(NSUInteger, TPDiaryModuleMessageType) {
    /// 用户发布
    TPDiaryModulePublic = 200000,
    /// 获取 日常列表
    TPDiaryFetchDatas,
    /// 更多日常
    TPDiaryFetchMoreDatas,
};

@interface TPDiaryModule : NSObject <TPDBModuleProtocol>

@end


