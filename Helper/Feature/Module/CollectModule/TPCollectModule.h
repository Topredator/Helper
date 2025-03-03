//
//  TPCollectModule.h
//  Helper
//
//  Created by Topredator on 2025/3/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define TABLE_NAME_COLLECT  @"Collect_"

typedef NS_ENUM(NSInteger, TPCollectModuleMessageType) {
    /// 添加收藏
    TPCollectionModuleAddCollect = 600000,
    /// 删除收藏
    TPCollectMododuleRemoveCollect,
    /// 查询收藏
    TPCollectModuleQueryData,
    
    /// 获取用户收藏数据
    TPCollectModuleFetchUserCollectDatas,
    TPCollectModuleFetchUserCollectMoreDatas,
};

/// 收藏模块
@interface TPCollectModule : NSObject <TPDBModuleProtocol>

@end

NS_ASSUME_NONNULL_END
