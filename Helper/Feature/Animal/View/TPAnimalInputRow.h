//
//  TPReleaseAdoptInputRow.h
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import <TPFoundation/TPFoundation.h>

@interface TPAnimalInputCell : TPUIBaseTableViewCell

@end

/// 发布领养 带有输入框的单元格
@interface TPAnimalInputRow : TPTableRow
@property (nonatomic, weak) TPAnimalInputCell *cell;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;

/// 姓名
+ (instancetype)nameRowWithId:(NSString *)rowId;
/// 品种
+ (instancetype)breedRowWithId:(NSString *)rowId;
/// 编号
+ (instancetype)numberRowWithId:(NSString *)rowId;
/// 年龄
+ (instancetype)ageRowWithId:(NSString *)rowId;
@end


