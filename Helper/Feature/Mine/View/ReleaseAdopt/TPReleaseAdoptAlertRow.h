//
//  TPReleaseAdoptAlertRow.h
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import <TPFoundation/TPFoundation.h>

@interface TPReleaseAdoptAlertCell : TPUIBaseTableViewCell

@end

@interface TPReleaseAdoptAlertRow : TPTableRow
@property (nonatomic, weak) TPReleaseAdoptAlertCell *cell;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *text;

/// 种类
+ (instancetype)categoryRowWithId:(NSString *)rowId;
/// 性别
+ (instancetype)genderRowWithId:(NSString *)rowId;
@end


