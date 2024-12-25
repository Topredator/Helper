//
//  TPSettingSwitchRow.h
//  Helper
//
//  Created by Topredator on 2024/12/24.
//

#import <TPFoundation/TPFoundation.h>
#import "TPBackgroundCell.h"
@interface TPSettingSwitchCell : TPBackgroundCell

@end

typedef void(^TPSettingSwitchCallback)(BOOL isOn);

/// 设置 - 带有开关的 单元格
@interface TPSettingSwitchRow : TPTableRow
@property (nonatomic, weak) TPSettingSwitchCell *cell;
@property (nonatomic, copy) TPSettingSwitchCallback callback;
+ (instancetype)rowWithName:(NSString *)name image:(NSString *)image status:(BOOL)status;
@end


