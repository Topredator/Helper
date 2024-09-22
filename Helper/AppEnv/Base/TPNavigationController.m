//
//  TPNavigationController.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "TPNavigationController.h"

@interface TPNavigationController ()

@end

@implementation TPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = UIColor.whiteColor;
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.titleTextAttributes = @{
        NSFontAttributeName: [TPUI tp_font:18 weight:FontMedium],
        NSForegroundColorAttributeName : [TPUI tp_t:51]
    };
    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [TPUI tp_r:101 g:109 b:127],
        NSFontAttributeName: [TPUI tp_font:10 weight:FontRegular]
    } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [TPUI tp_r:39 g:119 b:248],
        NSFontAttributeName: [TPUI tp_font:10 weight:FontRegular]
    } forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
}

- (void)configWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    self.tabBarItem.title = title;
    self.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage =
        [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
