//
//  TPAuthButtonRow.h
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import <TPFoundation/TPFoundation.h>

@interface TPAuthButtonCell : TPUIBaseTableViewCell
@property (nonatomic, strong, readonly) UIButton *button;
@end


@interface TPAuthButtonRow : TPTableRow
@property (nonatomic, weak, readonly) TPAuthButtonCell *cell;
@property (nonatomic, copy) NSString *title;

/// 默认按钮
+ (instancetype)rowWithID:(id<NSCopying>)rowid title:(NSString *)title;

/// 登录按钮
+ (instancetype)loginRowWithAccount:(RACSignal *)accountSignal password:(RACSignal *)pwdSignal;
/// 注册按钮
+ (instancetype)registerRowWithAccount:(RACSignal *)accountSignal pwd:(RACSignal *)pwdSignal;
/// 设置新密码
+ (instancetype)changePwdRowWithAccount:(RACSignal *)acountSignal newPwd:(RACSignal *)newSignal surePwd:(RACSignal *)sureSignal;
/// 添加点击事件
- (void)setTarget:(id)target action:(SEL)action;
@end


