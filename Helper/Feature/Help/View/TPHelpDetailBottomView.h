//
//  TPAdoptDetailBottomView.h
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPBaseView.h"

NS_ASSUME_NONNULL_BEGIN

/// 底部视图
@interface TPHelpDetailBottomView : TPBaseView
/// 收藏
@property (nonatomic, strong) TPUISimButton *collectBtn;
/// 捐赠
@property (nonatomic, strong) UIButton *donateBtn;
/// 领养
@property (nonatomic, strong) UIButton *wantAdoptBtn;
/// 收藏回调
@property (nonatomic, copy) dispatch_block_t collectionCallback;
/// 想领养 回调
@property (nonatomic, copy) dispatch_block_t wantAdoptCallback;
/// 是否收藏过
- (void)configCollected:(BOOL)isCollected;
@end

NS_ASSUME_NONNULL_END
