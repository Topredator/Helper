//
//  TPHomeBannerPage.m
//  Helper
//
//  Created by Topredator on 2024/12/21.
//

#import "TPHomeBannerPage.h"

@interface TPHomeBannerPage ()
@property (nonatomic, strong) UIImageView *bannerImage;
@end

@implementation TPHomeBannerPage

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews {
    self.backgroundColor = [TPUI tp_t:205];
    [self addSubview:self.bannerImage];
    [self.bannerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)configWithModel:(TPHomeBannerModel *)model {
    self.bannerImage.image = [UIImage imageNamed:model.publishModel.image];
}
#pragma mark---------- Getter -------------
- (UIImageView *)bannerImage {
    if (!_bannerImage) {
        _bannerImage                        = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bannerImage.userInteractionEnabled = YES;
        _bannerImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bannerImage;
}
@end
