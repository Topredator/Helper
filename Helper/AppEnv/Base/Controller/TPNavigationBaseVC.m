//
//  TPNavigationBaseVC.m
//  Helper
//
//  Created by Topredator on 2024/10/14.
//

#import "TPNavigationBaseVC.h"

@interface TPNavigationBaseVC ()

@end

@implementation TPNavigationBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupSubviews {
    [self.view addSubview:self.navigationView];
}
- (void)makeConstraints {
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(TPUI.tp_topBarHeight);
    }];
}
- (BOOL)showBack {
    return self.navigationController.childViewControllers.count > 1;
}
#pragma mark----------------- Getter -----------------
- (TPNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [self showBack] ? [TPNavigationView backView] : [TPNavigationView normalView];
        _navigationView.showLines = YES;
    }
    return _navigationView;
}
@end
