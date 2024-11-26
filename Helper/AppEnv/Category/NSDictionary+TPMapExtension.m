//
//  NSDictionary+TPMapExtension.m
//  Helper
//
//  Created by Topredator on 2024/11/25.
//

#import "NSDictionary+TPMapExtension.h"

@implementation NSDictionary (TPMapExtension)
- (NSDictionary *)keyRemovePrefix:(NSString *)prefix {
    if (!prefix) return self;
    NSMutableDictionary *mDic = @{}.mutableCopy;
    for (NSString *key in self.allKeys) {
        if ([key hasPrefix:prefix]) {
            NSString *resultKey = [key substringFromIndex:prefix.length];
            [mDic setValue:self[key] forKey:resultKey];
        } else {
            [mDic setValue:self[key] forKey:key];
        }
    }
    return mDic.copy;
}
- (NSDictionary *)keyAddPrefix:(NSString *)prefix {
    if (!prefix) return self;
    NSMutableDictionary *mDic = @{}.mutableCopy;
    for (NSString *key in self.allKeys) {
        [mDic setValue:self[key] forKey:[NSString stringWithFormat:@"%@%@", prefix, key]];
    }
    return mDic.copy;
}
@end
