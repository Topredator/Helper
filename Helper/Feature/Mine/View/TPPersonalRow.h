//
//  TPPersonalRow.h
//  Helper
//
//  Created by Topredator on 2025/3/11.
//

#import <TPFoundation/TPFoundation.h>
#import "TPBackgroundCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPPersonalCell : TPBackgroundCell

@end

@interface TPPersonalRow : TPTableRow
@property (nonatomic, weak) TPPersonalCell *cell;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL isAvatar;
+ (instancetype)rowWithTitle:(NSString *)title text:(NSString *)text isAvatar:(BOOL)isAvatar identify:(NSString *)identify;
@end

NS_ASSUME_NONNULL_END
