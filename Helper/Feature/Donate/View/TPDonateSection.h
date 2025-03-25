//
//  TPDonateSection.h
//  Helper
//
//  Created by Topredator on 2025/3/21.
//

#import <TPFoundation/TPFoundation.h>
#import "TPDonateModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPDonateSection : TPTableSection
@property (nonatomic, strong) TPDonateCategoryModel *categoryModel;
+ (instancetype)sectionWithModel:(TPDonateCategoryModel *)model;
@end

NS_ASSUME_NONNULL_END
