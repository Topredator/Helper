//
//  TPPublishSingleImageRow.h
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPBannerImageCell : TPUIBaseTableViewCell

@end

// 单个图片row
@interface TPBannerImageRow : TPTableRow
@property (nonatomic, weak) TPBannerImageCell *cell;
@property (nonatomic, copy, nullable) NSString *imageName;
@end

NS_ASSUME_NONNULL_END
