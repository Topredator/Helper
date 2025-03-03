//
//  TPHomeLifeDiaryRow.h
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import <TPFoundation/TPFoundation.h>
#import "TPPublishModel.h"
NS_ASSUME_NONNULL_BEGIN

/// 首页 生活日记 单元格
@interface TPHomeLifeDiaryRow : TPCollectionRow
+ (instancetype)rowWithModel:(TPPublishModel *)model;
@end

NS_ASSUME_NONNULL_END
