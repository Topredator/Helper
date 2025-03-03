//
//  TPAnimalListVC.h
//  Helper
//
//  Created by Topredator on 2025/3/2.
//

#import "TPNavigationTableVC.h"
#import "TPAnimalModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^TPAnimalListSelectAnimalCalllBack)(TPAnimalModel *model);

/// 宠物列表页
@interface TPAnimalListVC : TPNavigationTableVC
/// 选择回调
@property (nonatomic, copy) TPAnimalListSelectAnimalCalllBack callback;
@end

NS_ASSUME_NONNULL_END
