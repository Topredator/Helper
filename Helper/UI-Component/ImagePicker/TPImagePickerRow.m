//
//  TPImagePickerRow.m
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import "TPImagePickerRow.h"

@interface TPImagePickerCell ()
/// 内容图片
@property (nonatomic, strong) UIImageView *contentImage;
/// 选中图片
@property (nonatomic, strong) UIImageView *selectedImage;
@end

@implementation TPImagePickerCell
- (void)setupSubviews {
    [self.contentView addSubview:self.contentImage];
    [self.contentView addSubview:self.selectedImage];
}
- (void)makeConstraints {
    [self.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
    }];
}
#pragma mark ==================  Getter   ==================
- (UIImageView *)contentImage {
    if (!_contentImage) {
        _contentImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _contentImage;
}
- (UIImageView *)selectedImage {
    if (!_selectedImage) {
        _selectedImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _selectedImage.image = [UIImage imageNamed:@"image_picker_unselected"];
    }
    return _selectedImage;
}
@end

@interface TPImagePickerRow ()

@end

@implementation TPImagePickerRow
@dynamic cell;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setCellClass:TPImagePickerCell.class];
    }
    return self;
}
+ (instancetype)rowWithImageName:(NSString *)imageName {
    TPImagePickerRow *row = [TPImagePickerRow row];
    row.imageName = imageName;
    return row;
}
- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (self.cell) {
        self.cell.selectedImage.image = [UIImage imageNamed:selected ? @"image_picker_selected" : @"image_picker_unselected"];
    }
}
- (void)tp_collectionViewPreparedCell:(TPImagePickerCell *)cell proxy:(TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.selectedImage.hidden = !self.isMultiple;
    cell.selectedImage.image = [UIImage imageNamed:self.selected ? @"image_picker_selected" : @"image_picker_unselected"];
    cell.contentImage.image = [UIImage imageNamed:self.imageName];
    [super tp_collectionViewPreparedCell:cell proxy:proxy indexPath:indexPath];
}
@end
