//
//  UIView+TPUIToast.m
//  Helper
//
//  Created by Topredator on 2024/10/17.
//

#import "UIView+TPUIToast.h"

@implementation UIView (TPUIToast)
- (TPUIToast *)tp_showLoading {
    [TPUIToast hideInView:self];
    TPUIToast *toast = [TPUIToast showHUDAddedTo:self animated:YES];
    toast.mode = MBProgressHUDModeIndeterminate;
    toast.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    return toast;
}

- (void)tp_hideLoading {
    [TPUIToast hideHUDForView:self animated:YES];
}

- (TPUIToast *)tp_toast:(NSString *)string {
    return [self tp_toast:string duration:[TPUIToast durationForDisplayString:string ?: @""]];
}

- (TPUIToast *)tp_toast:(NSString *)string duration:(NSTimeInterval)duration {
    if (!string) return nil;
    [TPUIToast hideInView:self];
    TPUIToast *toast = [TPUIToast showHUDAddedTo:self animated:YES];
    toast.margin = 18;
    toast.mode = MBProgressHUDModeText;
    toast.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    toast.detailsLabel.textColor = UIColor.whiteColor;
    toast.detailsLabel.text = string;
    toast.detailsLabel.font = [UIFont boldSystemFontOfSize:16];
    [toast hideAnimated:YES afterDelay:duration];
    return toast;
}
@end
