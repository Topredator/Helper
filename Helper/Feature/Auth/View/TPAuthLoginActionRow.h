//
//  TPAuthLoginActionRow.h
//  Helper
//
//  Created by Topredator on 2024/10/15.
//

#import <TPFoundation/TPFoundation.h>

@interface TPAuthLoginActionCell : TPUIBaseTableViewCell
/// 注册按钮
@property (nonatomic, strong) UIButton *registerBtn;
/// 忘记密码按钮
@property (nonatomic, strong) UIButton *forgotPasswordBtn;
@end


@interface TPAuthLoginActionRow : TPTableRow
+ (instancetype)rowWithTarget:(id)target registerAction:(SEL)registerAction forgotPwdAction:(SEL)forgotAction;
@end


