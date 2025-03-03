//
//  TPAnimalVC.h
//  Helper
//
//  Created by Topredator on 2025/2/25.
//

#import "TPNavigationTableVC.h"
#import "TPAnimalModel.h"
NS_ASSUME_NONNULL_BEGIN


typedef void(^TPAnimalInfoBlock)(TPAnimalModel *model);

/// 宠物页
@interface TPAnimalVC : TPNavigationTableVC
/// 宠物模型
@property (nonatomic, strong) TPAnimalModel *animalModel;
@property (nonatomic, copy) TPAnimalInfoBlock infoBlock;
@end

NS_ASSUME_NONNULL_END
