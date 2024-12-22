//
//  TPBaseVC.m
//  Helper
//
//  Created by Topredator on 2024/9/22.
//

#import "TPBaseVC.h"


@interface TPBaseVC ()

@end

@implementation TPBaseVC

- (instancetype)init {
    self = [super init];
    if (self) {
        [TPDBRouter addRoute:self];
    }
    return self;
}
- (void)dealloc {
    [TPDBRouter removeRoute:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tpUINavigationItem.navigationBarHidden = YES;
    self.view.backgroundColor = TPHelperDefaultBgColor;
    [self setupSubviews];
    [self makeConstraints];
}
- (void)setupSubviews {}
- (void)makeConstraints {}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    return NO;
}
@end
