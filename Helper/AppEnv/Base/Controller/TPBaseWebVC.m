//
//  TPBaseWebVC.m
//  Helper
//
//  Created by Topredator on 2025/2/6.
//

#import "TPBaseWebVC.h"
#import "TPWebView.h"
@interface TPBaseWebVC () <TPWebViewNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) TPWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation TPBaseWebVC
- (instancetype)init {
    self = [super init];
    if (self) {
        self.autoTitle = YES;
        self.autoProgress = YES;
    }
    return self;
}
- (void)dealloc
{
    [self.webView clear];
    if (self.autoTitle) {
        [self.webView removeObserver:self forKeyPath:@"title"];
    }
    if (self.autoProgress) {
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addOBS];
    [self startRequest];
}
- (void)setupSubviews {
    [super setupSubviews];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.webView];
}
- (void)makeConstraints {
    [super makeConstraints];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.navigationView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
}
#pragma mark - observer
- (void)addOBS
{
    if (self.autoTitle) {
         [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }
    if (self.autoProgress) {
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([object isEqual:self.webView]) {
        if ([keyPath isEqualToString:@"title"]){
            NSString *title = change[NSKeyValueChangeNewKey];
            self.navigationView.title = title;
        } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
            self.progressView.progress = self.webView.estimatedProgress;
            if (self.progressView.progress >= 1.0) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.progressView.alpha = 0;
                }];
            } else {
                self.progressView.alpha = 1;
            }
        }
    }
}
- (void)setFileName:(NSString *)fileName {
    _fileName = fileName;
    self.webView.fileName = fileName;
}
- (void)setUrl:(NSString *)url {
    _url = url;
    self.webView.curl = url;
}
- (void)startRequest {
    [self.webView startRequest];
}
#pragma mark ==================  Getter   ==================
- (TPWebView *)webView {
    if (!_webView) {
        _webView = [[TPWebView alloc] initWithFrame:CGRectZero configuration:nil];
//        _webView.tp_uiDelegate = self;
//        _webView.tp_navDelegate = self;
    }
    return _webView;
}
- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
        _progressView.progress = 0;
        _progressView.progressTintColor = [UIColor blueColor];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}
@end
