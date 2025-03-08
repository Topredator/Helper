//
//  TPAddressTFRow.h
//  Helper
//
//  Created by Topredator on 2025/3/6.
//

#import <TPFoundation/TPFoundation.h>
#import "TPBackgroundCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPAddressTFCell : TPBackgroundCell

@end


#define kTPAddressNameKey @"com.helper.setting.address.name.row"
#define kTPAddressPhoneKey @"com.helper.setting.address.phone.row"

@interface TPAddressTFRow : TPTableRow
@property (nonatomic, weak) TPAddressTFCell *cell;
/// 是否数字键盘
@property (nonatomic, assign) BOOL isNumericKeyboard;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;
+ (instancetype)nameTitle:(NSString *)title;
+ (instancetype)phoneTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
