//
//  TPAdoptVC.m
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import "TPAdoptVC.h"
#import "TPAdoptItemVC.h"


@interface TPAdoptVC ()
@end

@implementation TPAdoptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"领养";
    [self configUI];
    self.viewControllers = @[
        [TPAdoptItemVC itemType:TPAdoptItemTypeAll],
        [TPAdoptItemVC itemType:TPAdoptItemTypeCat],
        [TPAdoptItemVC itemType:TPAdoptItemTypeDog],
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
