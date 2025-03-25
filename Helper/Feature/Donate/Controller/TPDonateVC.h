//
//  TPDonateVC.h
//  Helper
//
//  Created by Topredator on 2025/3/21.
//

#import "TPNavigationTableVC.h"
#import "TPUserModel.h"
#import "TPAnimalModel.h"


NS_ASSUME_NONNULL_BEGIN
/// 捐赠页
@interface TPDonateVC : TPNavigationTableVC
/// 发布人信息
@property (nonatomic, strong) TPUserModel *user;
/// 宠物信息
@property (nonatomic, strong) TPAnimalModel *animal;
@end

NS_ASSUME_NONNULL_END
