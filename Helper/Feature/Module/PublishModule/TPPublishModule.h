//
//  TPPublishModule.h
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define TABLE_NAME_PUBLISH  @"Publish_"

#define TABLE_NAME_IMAGE @"Image_"


typedef NS_ENUM(NSInteger, TPPublishModuleMessageType) {
    /// 发布消息
    TPPublishModulePublishMessage = 500000,
    /// 获取首页banner
    TPHomeBannerDatas,
    /// 获取日记数据
    TPPublishDiaryDatas,
    /// 更多日记数据
    TPPublishDiaryMoreDatas,
    
    /// 动物数据
    TPPublishAnimalDatas,
    /// 更多动物数据
    TPPublishAnimalMoreDatas,
    
    /// 全部动物信息
    TPFetchAllAnimalDatas,
    TPFetchAllAnimalMoreDatas,
    
    /// 待救助
    TPFetchBeRescuedAnimalDatas,
    TPFetchBeRescuedAnimalMoreDatas,
    /// 康复中
    TPFetchInRecoveryAnimalDatas,
    TPFetchInRecoveryAnimalMoreDatas,
    /// 待领养
    TPFetchPendingAdoptAnimalDatas,
    TPFetchPendingAdoptAnimalMoreDatas
};

/// 发布模块
@interface TPPublishModule : NSObject <TPDBModuleProtocol>

@end

NS_ASSUME_NONNULL_END
