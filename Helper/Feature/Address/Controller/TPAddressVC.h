//
//  TPAddressVC.h
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import "TPNavigationTableVC.h"
#import "TPAddressModel.h"
NS_ASSUME_NONNULL_BEGIN
// 编辑或新增地址
@interface TPAddressVC : TPNavigationTableVC
@property (nonatomic, strong) TPAddressModel *addressModel;
@end

NS_ASSUME_NONNULL_END
