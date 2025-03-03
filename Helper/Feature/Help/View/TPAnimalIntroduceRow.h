//
//  TPAdoptIntroduceRow.h
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPAnimalIntroduceCell : TPUIBaseTableViewCell

@end

@interface TPAnimalIntroduceRow : TPTableRow
@property (nonatomic, weak) TPAnimalIntroduceCell *cell;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@end

NS_ASSUME_NONNULL_END
