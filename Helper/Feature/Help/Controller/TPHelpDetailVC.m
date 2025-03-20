//
//  TPAdoptDetailVC.m
//  Helper
//
//  Created by Topredator on 2024/12/26.
//

#import "TPHelpDetailVC.h"
#import "TPAnimalCategoryRow.h"
#import "TPCommonTitleSection.h"
#import "TPAnimalIntroduceRow.h"
#import "TPAnimalPublisherRow.h"
#import "TPHelpDetailBottomView.h"
#import "TPCollectModule.h"
#import "TPCollectModel.h"
#import "TPAgreenebtPromptView.h"
#import "TPApplyModel.h"
#import "TPAdoptConditionRow.h"
@interface TPHelpDetailVC ()
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) TPHelpDetailBottomView *bottomView;
@property (nonatomic, assign) BOOL isCollection;
@end

@implementation TPHelpDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.title = [self fetchTitle];
    [self loadData];
    [self operationAction];
}
- (NSString *)fetchTitle {
    switch (self.publishModel.type) {
        case TPPublishTypeToBeRescued: return @"待救助";
        case TPPublishTypeInRecovery: return @"康复中";
        case TPPublishTypeAdopt: return @"待领养";
        default: return @"详情";
    }
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.bottomView];
    self.bottomView.wantAdoptBtn.hidden = !(self.publishModel.type == TPPublishTypeAdopt && ![self.publishModel.user.userId isEqualToString:TPUserManager.manager.user.userId]);
    self.bottomView.donateBtn.hidden = !(self.publishModel.type != TPPublishTypeToBeRescued && ![self.publishModel.user.userId isEqualToString:TPUserManager.manager.user.userId]);
    [self.headerView addSubview:self.avatarImage];
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.tableview.tableHeaderView = self.headerView;
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TPUI.tp_screenWidth, 0.01)];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-64 - TPUI.tp_bottomSafeAreaHeight);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.tableview.mas_bottom);
    }];
}
- (void)operationAction {
    // 收藏回调
    @weakify(self);
    self.bottomView.collectionCallback = ^{
        @strongify(self);
        if (self.isCollection) {
            [TPDBRouter sendTaskMessage:TPCollectMododuleRemoveCollect argument:self.publishModel.animal.animalId];
        } else {
            TPCollectModel *collectModel = [TPCollectModel generateWithAnimalId:self.publishModel.animal.animalId];
            [TPDBRouter sendTaskMessage:TPCollectionModuleAddCollect argument:[collectModel tp_modelToJSONObject]];
        }
    };
    // 想领养回调
    self.bottomView.wantAdoptCallback = ^{
        @strongify(self);
        TPAgreenebtPromptView *promptView = [TPAgreenebtPromptView view];
        [promptView configTitle:@"提示" content:@"确定符合领养条件吗?"];
        promptView.callback = ^{
            @strongify(self);
            [self applyAdopt];
        };
        [promptView showIn:self.view];
    };
}
- (void)applyAdopt {
    [self.view tp_showLoading];
    TPApplyModel *model = [TPApplyModel modelWithUserId:self.publishModel.userId animalId:self.publishModel.animal.animalId];
    [TPDBRouter sendTaskMessage:TPApplyToAdoptAnimal argument:[model tp_modelToJSONObject]];
}

- (void)loadData {
    
    [TPDBRouter sendTaskMessage:TPCollectModuleQueryData argument:self.publishModel.animal.animalId];
    
    self.avatarImage.image = [UIImage imageNamed:self.publishModel.animal.thumbImage];
    TPCommonTitleSection *section = [TPCommonTitleSection sectionWithTitle:self.publishModel.animal.name];
    [section addObject:[TPAnimalCategoryRow rowWithModel:self.publishModel.animal]];
    
    TPAnimalIntroduceRow *introduceRow = [TPAnimalIntroduceRow row];
    introduceRow.title = self.publishModel.title;
    introduceRow.content = self.publishModel.content;
    [section addObject:introduceRow];
    
    TPCommonTitleSection *conditionSection = [TPCommonTitleSection sectionWithTitle:@"领养条件"];
    [conditionSection addObject:[TPAdoptConditionRow conditionRowWithTitle:@"必须要签订领养协议, 需要互换身份证复印件" isSelected:YES]];
    [conditionSection addObject:[TPAdoptConditionRow conditionRowWithTitle:@"不接受学生领养" isSelected:YES]];
    [conditionSection addObject:[TPAdoptConditionRow conditionRowWithTitle:@"养猫封窗，养狗牵绳" isSelected:YES]];
    [conditionSection addObject:[TPAdoptConditionRow conditionRowWithTitle:@"年龄需要20岁以上，未成年人需监护人申请" isSelected:YES]];
    [conditionSection addObject:[TPAdoptConditionRow conditionRowWithTitle:@"有稳定住房" isSelected:YES]];
    [conditionSection addObject:[TPAdoptConditionRow conditionRowWithTitle:@"仅限同城，不可邮寄" isSelected:YES]];
    [conditionSection addObject:[TPAdoptConditionRow conditionRowWithTitle:@"按时打疫苗驱虫" isSelected:YES]];
    [conditionSection addObject:[TPAdoptConditionRow conditionRowWithTitle:@"接收领养前家访，领养后家访" isSelected:YES]];
    [conditionSection addObject:[TPAdoptConditionRow conditionRowWithTitle:@"工作稳定，有一定经济基础" isSelected:YES]];
    
    
    TPCommonTitleSection *publicSection = [TPCommonTitleSection sectionWithTitle:@"发布者"];
    [publicSection addObject:[TPAnimalPublisherRow rowWithModel:self.publishModel.user]];
    
    TPCommonTitleSection *flowSection = [TPCommonTitleSection sectionWithTitle:@"领养流程"];
    [flowSection addObject:[TPAdoptConditionRow flowWithTitle:@"确认满足上方领养要求"]];
    [flowSection addObject:[TPAdoptConditionRow flowWithTitle:@"通过上方联系方式与送养人取得联系"]];
    [flowSection addObject:[TPAdoptConditionRow flowWithTitle:@"沟通交流，协商一致后现场交接，签订领养协议"]];
    
    [self reloadData:@[section, conditionSection, publicSection, flowSection]];
}
- (BOOL)handleMessage:(NSInteger)messageType result:(NSInteger)result argument:(id)argument {
    if (messageType == TPCollectModuleQueryData) {
        NSArray *datas = (NSArray *)argument;
        self.isCollection = datas.count > 0;
        [self.bottomView configCollected:datas.count > 0];
        return YES;
    } else if (messageType == TPCollectionModuleAddCollect ||
               messageType == TPCollectMododuleRemoveCollect) {
        [TPDBRouter sendTaskMessage:TPCollectModuleQueryData argument:self.publishModel.animal.animalId];
        return YES;
    } else if (messageType == TPApplyToAdoptAnimal) {
        [self.view tp_toast:@"申请成功"];
        return YES;
    } else if (messageType == TPApplyToAdminWaiting) {
        [self.view tp_toast:@"已申请过，无须重复申请"];
        return YES;
    }
    return NO;
}

#pragma mark----------------- Getter -----------------
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TPUI.tp_screenWidth, TPUI.tp_screenWidth)];
        _headerView.backgroundColor = UIColor.whiteColor;
    }
    return _headerView;
}
- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _avatarImage;
}
- (TPHelpDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [TPHelpDetailBottomView view];
    }
    return _bottomView;
}
@end
