//
//  TPRootVC.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "TPRootVC.h"
#import "TPTopicVC.h"
#import "TPDiscoverVC.h"
#import "TPNotifyVC.h"
#import "TPMineVC.h"
#import "TPNavigationController.h"

@interface TPRootVC ()

@end

@implementation TPRootVC
- (instancetype)init {
    self = [super init];
    if (self) {
        if (@available(iOS 10.0, *)) self.tabBar.unselectedItemTintColor = [TPUI tp_t:102];
        self.tabBar.tintColor = [TPUI tp_r:39 g:119 b:248];
        self.tabBar.layer.shadowColor = [TPUI tp_t:0 alpha:0.1].CGColor;
        self.tabBar.layer.shadowOffset = CGSizeMake(0, -1);
        self.tabBar.layer.shadowOpacity = 0.3;
        
        if (@available(iOS 13.0, *)) {
            UITabBarAppearance *appearance = self.tabBar.standardAppearance.copy;
            [appearance setShadowImage:[UIImage tp_imageWithColor:UIColor.whiteColor]];
            [appearance setBackgroundImage:[UIImage tp_imageWithColor:UIColor.whiteColor]];
            self.tabBar.standardAppearance = appearance;
        } else {
            [[UITabBar appearance] setShadowImage:[UIImage new]];
            [[UITabBar appearance] setBackgroundImage:[UIImage new]];
        }
        [UITabBar.appearance setTranslucent:NO];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configViewControllers];
}
- (void)configViewControllers {
    TPTopicVC *topicVC = [TPTopicVC new];
    TPNavigationController *topicNavigationVC = [[TPNavigationController alloc] initWithRootViewController:topicVC];
    [topicNavigationVC configWithTitle:@"话题" imageName:@"tabbar_topic" selectedImageName:@"tabbar_topic_selected"];
    
    TPNotifyVC *notifyVC = [TPNotifyVC new];
    TPNavigationController *notifyNavigationVC = [[TPNavigationController alloc] initWithRootViewController:notifyVC];
    [notifyNavigationVC configWithTitle:@"通知" imageName:@"tabbar_notify" selectedImageName:@"tabbar_notify_selected"];
    
    TPDiscoverVC *discoverVC = [TPDiscoverVC new];
    TPNavigationController *discoverNavigationVC = [[TPNavigationController alloc] initWithRootViewController:discoverVC];
    [discoverNavigationVC configWithTitle:@"发现" imageName:@"tabbar_discovery" selectedImageName:@"tabbar_discovery_selected"];
    
    TPMineVC *mineVC = [TPMineVC new];
    TPNavigationController *mineNavigationVC = [[TPNavigationController alloc] initWithRootViewController:mineVC];
    [mineNavigationVC configWithTitle:@"我的" imageName:@"tabbar_mine" selectedImageName:@"tabbar_mine_selected"];
    
    self.viewControllers = @[topicNavigationVC, notifyNavigationVC, discoverNavigationVC, mineNavigationVC];
}
@end
