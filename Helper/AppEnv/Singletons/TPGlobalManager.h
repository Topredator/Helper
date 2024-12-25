//
//  TPGlobalManager.h
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 全局管理器
@interface TPGlobalManager : NSObject
/// 是否第一次加载
@property (nonatomic, assign, getter=isFirstLoad) BOOL firstLoad;
+ (instancetype)manager;
@end

NS_ASSUME_NONNULL_END
