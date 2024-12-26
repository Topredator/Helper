//
//  TPHomeBannerModel.h
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import <Foundation/Foundation.h>
#import "TPAdoptModel.h"

NS_ASSUME_NONNULL_BEGIN
/// 首页banner 模型
@interface TPHomeBannerModel : NSObject

@property (nonatomic, strong) TPAdoptModel *adoptModel;

/// 图片名称
@property (nonatomic, copy) NSString *imageName;
+ (instancetype)bannerWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
