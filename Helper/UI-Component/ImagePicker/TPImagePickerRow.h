//
//  TPImagePickerRow.h
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import <TPFoundation/TPFoundation.h>
#import "TPCommonCollectionCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPImagePickerCell : TPCommonCollectionCell

@end

/// 图片选择单元格
@interface TPImagePickerRow : TPCollectionRow
@property (nonatomic, weak) TPImagePickerCell *cell;
@property (nonatomic, copy) NSString *imageName;
/// 是否选中
@property (nonatomic, assign) BOOL selected;
/// 是否多选
@property (nonatomic, assign) BOOL isMultiple;
+ (instancetype)rowWithImageName:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
