//
//  TPImagePickerSection.m
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import "TPImagePickerSection.h"

@interface TPImagePickerSection ()
@property (nonatomic, assign) NSInteger column;
@end

@implementation TPImagePickerSection
+ (instancetype)sectionWithColumn:(NSInteger)column {
    TPImagePickerSection *section = [TPImagePickerSection section];
    section.column = column;
    return section;
}
- (UIEdgeInsets)tp_collectionSectionInsetWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return UIEdgeInsetsMake(10, 15, 10, 15);
}
- (CGSize)tp_collectionSectionFooterSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return CGSizeZero;
}
- (CGSize)tp_collectionSectionHeaderSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return CGSizeZero;
}
- (CGFloat)tp_collectionMinimumLineSpacingWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return 10;
}
- (CGFloat)tp_collectionMinimumInteritemSpacingWithProxy:(__kindof TPCollectionViewProxy *)proxy section:(NSInteger)section {
    return 0;
}
@end
