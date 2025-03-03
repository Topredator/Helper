//
//  TPCollectRow.h
//  Helper
//
//  Created by Topredator on 2025/3/3.
//

#import <TPFoundation/TPFoundation.h>
#import "TPCommonCollectionCell.h"
#import "TPCollectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPCollectCell : TPCommonCollectionCell

@end

@interface TPCollectRow : TPCollectionRow
@property (nonatomic, weak) TPCollectCell *cell;
+ (instancetype)rowWithModel:(TPCollectModel *)model;
@end

NS_ASSUME_NONNULL_END
