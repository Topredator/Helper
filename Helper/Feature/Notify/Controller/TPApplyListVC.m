//
//  TPReviewDetailVC.m
//  Helper
//
//  Created by Topredator on 2024/12/28.
//

#import "TPApplyListVC.h"
#import "TPApplyModel.h"
#import "TPUserModel.h"

@interface TPApplyListVC ()

@end

@implementation TPApplyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.title = @"申请列表";
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
}
- (void)loadData {
    [TPDBRouter sendTaskMessage:TPFetchApplyList];
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPFetchApplyList) {
        NSArray *array = argument;
        if (array.count) {
            NSDictionary *dic = [array firstObject];
            TPApplyModel *model = [TPApplyModel tp_modelWithJSON:dic];
            TPUserModel *user = [TPUserModel tp_modelWithJSON:dic[@"applicant"]];
            NSLog(@"%@", user.name);
            
        }
        return YES;
    }
    return NO;
}
@end
