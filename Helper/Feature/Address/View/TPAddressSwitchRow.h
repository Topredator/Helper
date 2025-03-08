//
//  TPAddressSwitchRow.h
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import <TPFoundation/TPFoundation.h>
#import "TPBackgroundCell.h"
NS_ASSUME_NONNULL_BEGIN



@interface TPAddressSwitchCell : TPBackgroundCell

@end

#define kTPAddressSwitchKey @"com.helper.setting.address.switch.row"

@interface TPAddressSwitchRow : TPTableRow
@property (nonatomic, weak) TPAddressSwitchCell *cell;
@property (nonatomic, assign, getter=isOn) BOOL on;
+ (instancetype)rowWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
