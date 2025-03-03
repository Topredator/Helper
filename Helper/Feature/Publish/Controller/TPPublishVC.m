//
//  TPPublishVC.m
//  Helper
//
//  Created by Topredator on 2025/2/20.
//

#import "TPPublishVC.h"
#import "TPPublishTitleRow.h"
#import "TPPublishContentRow.h"
#import "TPPublishAnimalRow.h"
#import "TPPublishSendRow.h"
#import "TPCommonSection.h"
#import "TPBannerImageRow.h"
#import "TPPublishContentRow.h"
#import "TPPublishSendRow.h"
#import "TPPublishModel.h"
#import "TPCommonSquareImageRow.h"
#import "TPAnimalModule.h"
#import "TPAnimalListVC.h"
#import "TPCommonMultipleImagesRow.h"
#import "TPCommonAnimalRow.h"
@interface TPPublishVC ()
@property (nonatomic, strong) TPCommonSection *section;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) TPAnimalModel *animalModel;
@end

@implementation TPPublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.title = [self fetchTitle];
    [self loadData];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.navigationView addSubview:self.selectBtn];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-7);
    }];
}
- (void)loadData {
    self.selectBtn.hidden = (self.type == TPPublishTypeDaily || self.type == TPPublishTypeLinkNotice || self.type == TPPublishTypeGraphicNotice);
    TPPublishTitleRow *titleRow = [TPPublishTitleRow row];
    [self.section addObject:titleRow];
    
    switch (self.type) {
        case TPPublishTypeLinkNotice:
        case TPPublishTypeGraphicNotice: {
            /// banner图片
            TPBannerImageRow *singleImageRow = [TPBannerImageRow row];
            [self.section addObject:singleImageRow];
        }
            break;
        default: {
            /// 九宫格图片
            TPCommonMultipleImagesRow *multipleRow = [TPCommonMultipleImagesRow rowWithID:kTPPublishMultipleImagesRowKey];
            [self.section addObject:multipleRow];
        }
            break;
    }
    
    /// 文案
    TPPublishContentRow *contentRow = [TPPublishContentRow row];
    [self.section addObject:contentRow];
    /// 发布按钮
    TPPublishSendRow *sendRow = [TPPublishSendRow row];
    [sendRow setTarget:self action:@selector(sendAction)];
    [self.section addObject:sendRow];
    
    
    [self reloadData:@[self.section]];
}
- (NSString *)fetchTitle {
    switch (self.type) {
        case TPPublishTypeLinkNotice: return @"链接公告";
        case TPPublishTypeGraphicNotice: return @"图文公告";
        case TPPublishTypeDaily: return @"日常";
        case TPPublishTypeToBeRescued: return @"待救助";
        case TPPublishTypeInRecovery: return @"康复中";
        case TPPublishTypeAdopt: return @"领养";
        default: return @"发布";
    }
}
- (void)sendAction {
    TPTableSection *section = self.tableview.TPProxy.data[0];
    /// 标题
    NSString *title = [(TPPublishTitleRow *)section[kTPPublishTitleRowKey] text];
    if (!title.length) {
        [self.view tp_toast:@"请输入标题" duration:1.5];
        return;
    }
    TPPublishModel *model = [TPPublishModel modelWithTitle:title];
    model.userId = TPUserManager.manager.user.userId;
    /// 内容
    NSString *content = [(TPPublishContentRow *)section[kTPPublishContentRowKey] text];
    if (!content.length) {
        [self.view tp_toast:@"请输入内容" duration:1.5];
        return;
    }
    model.content = content;
    model.type = self.type;
    switch (self.type) {
        case TPPublishTypeLinkNotice:
        case TPPublishTypeGraphicNotice: { // 公告 链接/图文
            NSString *imgName = [(TPBannerImageRow *)section[kTPPublishSingleImageRowKey] imageName];
            if (!imgName.length) {
                [self.view tp_toast:@"请选择公告logo" duration:1.5];
                return;
            }
            model.image = imgName;
        }
            break;
        case TPPublishTypeDaily: { // 日常
            NSArray *images = [(TPCommonMultipleImagesRow *)section[kTPPublishMultipleImagesRowKey] images];
            if (!images.count) {
                [self.view tp_toast:@"请添加图片" duration:1.5];
                return;
            }
            model.detailImages = [images tp_modelToJSONString];
        }
            break;
        default: {
            NSArray *images = [(TPCommonMultipleImagesRow *)section[kTPPublishMultipleImagesRowKey] images];
            if (!images.count) {
                [self.view tp_toast:@"请添加图片" duration:1.5];
                return;
            }
            if (!self.animalModel) {
                [self.view tp_toast:@"请选择或创建宠物" duration:1.5];
                return;
            }
            model.animalId = self.animalModel.animalId;
        }
            break;
    }
    [TPDBRouter sendTaskMessage:TPPublishModulePublishMessage argument:[model tp_modelToJSONObject]];
}
- (void)selectBtnAction {
    
    TPAnimalListVC *listVC = [TPAnimalListVC new];
    @weakify(self);
    listVC.callback = ^(TPAnimalModel * _Nonnull model) {
        @strongify(self);
        self.animalModel = model;
        
        TPCommonAnimalRow *beforeRow = (TPCommonAnimalRow *)self.section[@"commonAnimalRow"];
        if (beforeRow) {
            [self.section removeObject:beforeRow];
        }
        TPCommonAnimalRow *row = [TPCommonAnimalRow rowWithModel:model identifer:@"commonAnimalRow"];
        [self.section insertObject:row atIndex:1];
        [self reloadData:@[self.section]];
    };
    [TPUINavigator pushViewController:listVC animated:YES];
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPPublishModulePublishMessage) { // 发布成功
        [TPAppDelegate().window tp_toast:@"发布成功"];
        [TPUINavigator popViewControllerWithTimes:1 animated:YES];
        return YES;
    } 
    return NO;
}
#pragma mark ==================  Getter   ==================
- (TPCommonSection *)section {
    if (!_section) {
        _section = [TPCommonSection section];
    }
    return _section;
}
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_selectBtn setTitle:@"选择宠物" forState:UIControlStateNormal];
        [_selectBtn setTitleColor:TPHelperThemeColor forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = [TPUI tp_font:16 weight:FontMedium];
        [_selectBtn addTarget:self action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
@end
