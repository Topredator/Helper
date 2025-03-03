//
//  TPPublishMultipleImagesRow.h
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface TPCommonMultipleImagesCell : TPUIBaseTableViewCell

@end

/// 多张图片
@interface TPCommonMultipleImagesRow : TPTableRow
@property (nonatomic, weak) TPCommonMultipleImagesCell *cell;
@property (nonatomic, copy) NSArray *images;
/// 图片名称前缀
@property (nonatomic, copy) NSString *namePrefix;
@end

NS_ASSUME_NONNULL_END
