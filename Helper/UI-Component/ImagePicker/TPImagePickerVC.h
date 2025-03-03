//
//  TPNavigationCollectionVC.h
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import "TPBaseVC.h"
#import "TPNavigationView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TPImagePickerSingleBlock)(NSString *imageName);
typedef void(^TPImagePickerMultipleBlock)(NSArray *imageNames);

/// 图片选择器
@interface TPImagePickerVC : TPBaseVC
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TPNavigationView *navigationView;
@property (nonatomic, copy) TPImagePickerSingleBlock singleBlock;
@property (nonatomic, copy) TPImagePickerMultipleBlock multipleBlock;
/// 多少列 默认1
@property (nonatomic, assign) NSInteger column;
/// 最大选中 默认9
@property (nonatomic, assign) NSInteger maxSelected;
/// 是否能全选 与maxSelected冲突 
@property (nonatomic, assign) BOOL canAllSelected;
/// 总数
@property (nonatomic, assign) NSInteger total;
/// 图片名称前缀
@property (nonatomic, copy) NSString *namePrefix;
/// 是否多选
@property (nonatomic, assign) BOOL isMultiple;
@end

NS_ASSUME_NONNULL_END
