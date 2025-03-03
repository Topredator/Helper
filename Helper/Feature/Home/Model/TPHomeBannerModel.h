//
//  TPHomeBannerModel.h
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import <Foundation/Foundation.h>
#import "TPPublishModel.h"
NS_ASSUME_NONNULL_BEGIN
/// 首页banner 模型
@interface TPHomeBannerModel : NSObject

@property (nonatomic, strong) TPPublishModel *publishModel;
/// 图片名称
@property (nonatomic, copy) NSString *image;
+ (instancetype)bannerWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
