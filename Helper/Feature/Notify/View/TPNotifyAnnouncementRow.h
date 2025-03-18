//
//  TPNotifyAnnouncementRow.h
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import <TPFoundation/TPFoundation.h>
#import "TPPublishModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 通知 - 公告 单元格
@interface TPNotifyAnnouncementRow : TPTableRow
+ (instancetype)rowWithModel:(TPPublishModel *)model;
@end

NS_ASSUME_NONNULL_END
