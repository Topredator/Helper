//
//  UIView+TPCommonEmpty.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "UIView+TPCommonEmpty.h"

@implementation UIView (TPCommonEmpty)
- (TPUIImageBlankView *)tp_commonEmptyData {
    return [self tp_showBlankViewWithImage:[UIImage imageNamed:@"common_emptydata"]];
}
@end
