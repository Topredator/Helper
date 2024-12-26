//
//  TPReleaseAdoptSwitchRow.h
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import <TPFoundation/TPFoundation.h>

@interface TPReleaseAdoptSwitchCell : TPUIBaseTableViewCell

@end

/// 发布领养 带有开关的单元格
@interface TPReleaseAdoptSwitchRow : TPTableRow
@property (nonatomic, weak) TPReleaseAdoptSwitchCell *cell;
@property (nonatomic, assign, getter=isOn) BOOL on;
@property (nonatomic, copy) NSString *title;

/// 绝育
+ (instancetype)sterilizationRowWithId:(NSString *)rowId;
/// 驱虫
+ (instancetype)dewormingRowWithId:(NSString *)rowId;
/// 疫苗
+ (instancetype)vaccineRowWithId:(NSString *)rowId;

@end


