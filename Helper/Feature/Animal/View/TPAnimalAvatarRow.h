//
//  TPAnimalAvatarRow.h
//  Helper
//
//  Created by Topredator on 2025/2/25.
//

#import <TPFoundation/TPFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPAnimalAvatarCell : TPUIBaseTableViewCell

@end


/// 头像
@interface TPAnimalAvatarRow : TPTableRow
@property (nonatomic, weak) TPAnimalAvatarCell *cell;
@property (nonatomic, copy) NSString *avatar;
@end

NS_ASSUME_NONNULL_END
