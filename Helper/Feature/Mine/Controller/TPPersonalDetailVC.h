//
//  TPPersonalDetailVC.h
//  Helper
//
//  Created by Topredator on 2025/3/11.
//

#import "TPNavigationBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TPPersonalDetailCallback)(NSString *content);

@interface TPPersonalDetailVC : TPNavigationBaseVC
@property (nonatomic, copy) NSString *navigationTitle;
@property (nonatomic, copy) TPPersonalDetailCallback callback;
@property (nonatomic, assign) NSInteger maxText;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, copy) NSString *content;
@end

NS_ASSUME_NONNULL_END
