//
//  TPAdoptVC.m
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import "TPHelpVC.h"
#import "TPHelpItemVC.h"


@interface TPHelpVC ()
@end

@implementation TPHelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"救助";
    [self configUI];
    self.viewControllers = @[
        [TPHelpItemVC itemType:TPHelpItemTypeAll],
        [TPHelpItemVC itemType:TPHelpItemToBeRescued],
        [TPHelpItemVC itemType:TPHelpItemInRecovery],
        [TPHelpItemVC itemType:TPHelpItemPendingAdoption],
    ];
}
- (void)configUI {
    self.topTabBar.itemTitleColor = TPHelperDarkGrayTextColor;
    self.topTabBar.itemTitleSelectedColor = TPHelperThemeColor;
    self.topTabBar.indicatorColor = TPHelperThemeColor;
    self.topTabBar.itemTitleFont = [TPUI tp_font:18 weight:FontSemibold];
    self.topTabBar.itemTitleSelectedFont = [TPUI tp_font:20 weight:FontSemibold];
    [self.topTabBar setScrollEnabledAndItemFitTextWidthWithSpacing:50];
    self.banner.pageControl.hidden = YES;
}

@end
