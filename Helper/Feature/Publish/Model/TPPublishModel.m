//
//  TPPublishModel.m
//  Helper
//
//  Created by Topredator on 2025/2/21.
//

#import "TPPublishModel.h"

@implementation TPPublishModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.createTime = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate now] timeIntervalSince1970] * 1000];
    }
    return self;
}
+ (instancetype)modelWithTitle:(NSString *)title {
    TPPublishModel *model = TPPublishModel.new;
    model.title = title;
    model.publishId = [[NSString stringWithFormat:@"publish_%@_%@", title, model.createTime] tp_MD5];
    return model;
}

@end
