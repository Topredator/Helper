//
//  TPImagePickerBottomView.h
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import "TPBaseView.h"

NS_ASSUME_NONNULL_BEGIN
/// 底部视图
@interface TPImagePickerBottomView : TPBaseView
/// 全选
@property (nonatomic, strong) TPUISimButton *allBtn;
/// 确定按钮
@property (nonatomic, strong) UIButton *sureBtn;
@end

NS_ASSUME_NONNULL_END
