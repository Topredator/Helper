//
//  TPCollectListSection.m
//  Helper
//
//  Created by Topredator on 2025/3/3.
//

#import "TPCollectListSection.h"

@implementation TPCollectListSection
- (UIEdgeInsets)tp_collectionSectionInsetWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)tp_collectionMinimumLineSpacingWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return 10;
}
- (CGFloat)tp_collectionMinimumInteritemSpacingWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return 10;
}
@end
