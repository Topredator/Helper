//
//  TPAuthTextFieldRow.h
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import <TPFoundation/TPFoundation.h>

/// 包含输入框的cell
@interface TPAuthTextFieldCell : TPUIBaseTableViewCell
@property (nonatomic, strong, readonly) TPNoPasteTextField *textField;
@property (nonatomic, strong, readonly) TPLine *bottomLine;
@end


@interface TPAuthTextFieldRow : TPTableRow
@property (nonatomic, weak, readonly) TPAuthTextFieldCell *cell;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;

+ (instancetype)accountRow;
+ (instancetype)passwordRow;

+ (instancetype)rowWithId:(NSString *)identifier placeholder:(NSString *)placeholder;
@end

