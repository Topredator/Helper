//
//  TPReleaseAdoptAlertRow.h
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import <TPFoundation/TPFoundation.h>

@interface TPAnimalAlertCell : TPUIBaseTableViewCell

@end

@interface TPAnimalAlertRow : TPTableRow
@property (nonatomic, weak) TPAnimalAlertCell *cell;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *text;

/// 种类
+ (instancetype)categoryRowWithId:(NSString *)rowId;
/// 性别
+ (instancetype)genderRowWithId:(NSString *)rowId;
@end


