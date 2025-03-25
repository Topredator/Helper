//
//  TPDonateDetailVC.m
//  Helper
//
//  Created by Topredator on 2025/3/25.
//

#import "TPDonateDetailVC.h"
#import "TPDonateSection.h"
#import "TPDonateDetailRow.h"
#import "TPDonateDetailRow.h"
#import "TPAddressModule.h"
#import "TPDoneeInfoRow.h"
#import "TPCommonSection.h"
#import "TPAddressModel.h"
@interface TPDonateDetailVC ()
@property (nonatomic, strong) NSMutableArray *sections;
@end

@implementation TPDonateDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = @"捐赠详情";
    [self loadData];
    [self requestData];
}
- (void)loadData {
    [self.sections removeAllObjects];
    for (TPDonateCategoryModel *categoryModel in self.operate.categorys) {
        TPDonateSection *section = [TPDonateSection sectionWithModel:categoryModel];
        for (TPDonateItemModel *item in categoryModel.items) {
            TPDonateDetailRow *row = [TPDonateDetailRow rowWithModel:item];
            [section addObject:row];
        }
        [self.sections addObject:section];
    }
    
    [self reloadData:self.sections.copy];
}
- (void)requestData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        TPAddressModel *addressModel = [TPDBRouter syncSendTaskMessage:TPAddressFetchUserDefaultAddress argument:self.operate.donate.donee.userId];
        if (!addressModel) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            TPDoneeInfoRow *row = [TPDoneeInfoRow row];
            row.user = self.operate.donate.donee;
            row.address = addressModel.detailAddress;
            row.expressNumber = self.operate.donate.expressNumber;
            TPCommonSection *section = [TPCommonSection section];
//            section.h_height = 20;
            [section addObject:row];
            [self.sections addObject:section];
            [self reloadData:self.sections.copy];
        });
    });
}
#pragma mark ==================  Getter   ==================
- (NSMutableArray *)sections {
    if (!_sections) {
        _sections = @[].mutableCopy;
    }
    return _sections;
}
@end
