//
//  TPMineFunctionRow.h
//  Helper
//
//  Created by Topredator on 2024/12/19.
//

#import <TPFoundation/TPFoundation.h>


@interface TPMineFunctionCell : TPUIBaseTableViewCell
@end
/// 我的功能单元格
@interface TPMineFunctionRow : TPTableRow
@property (nonatomic, weak) TPMineFunctionCell *cell;
- (void)setPublicTarget:(id)target action:(SEL)action;
- (void)setCollectTarget:(id)target action:(SEL)action;
- (void)setDonateTarget:(id)target action:(SEL)action;
@end


