//
//  TPAddressTVRow.h
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import <TPFoundation/TPFoundation.h>
#import "TPBackgroundCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPAddressTVCell : TPBackgroundCell

@end

#define kTPAddressTVKey @"com.helper.setting.address.textview.row"

@interface TPAddressTVRow : TPTableRow
@property (nonatomic, weak) TPAddressTVCell *cell;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;
+ (instancetype)rowWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
