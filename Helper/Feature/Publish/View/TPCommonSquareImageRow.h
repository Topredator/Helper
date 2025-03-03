//
//  TPpublishSingleDetailImageRow.h
//  Helper
//
//  Created by Topredator on 2025/2/24.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPCommonSquareImageCell : TPUIBaseTableViewCell

@end

@interface TPCommonSquareImageRow : TPTableRow
@property (nonatomic, weak) TPCommonSquareImageCell *cell;
@property (nonatomic, copy, nullable) NSString *imageName;
@end

NS_ASSUME_NONNULL_END
