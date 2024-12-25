//
//  TPCommonSection.m
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import "TPCommonSection.h"

@implementation TPCommonSection
- (CGFloat)tp_tableViewHeaderHeightWithPorxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    return self.h_height ?: 0.01;
}
- (CGFloat)tp_tableViewFooterHeightWithPorxy:(TPTableViewProxy *)proxy section:(NSUInteger)section {
    return self.f_height ?: 0.01;
}
@end
