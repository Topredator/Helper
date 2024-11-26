//
//  TPTopicVC.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "TPTopicVC.h"

@interface TPTopicVC ()

@end

@implementation TPTopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *string = @"Topic";
    NSMutableAttributedString *attString = [string tp_mutableAttributedStringWithAttributes:@[
        [TPFontAttributeConfig tp_font:[TPUI tp_font:20 weight:FontMedium] range:NSMakeRange(0, string.length)],
        [TPForegroundColorAttributeConfig tp_color:[UIColor.blackColor colorWithAlphaComponent:0.5] range:NSMakeRange(0, string.length)],
        [TPForegroundColorAttributeConfig tp_color:[TPUI tp_r:52 g:152 b:219] range:NSMakeRange(0, 1)]
    ]];
    self.navigationView.attributeTitle = attString;
}

@end
