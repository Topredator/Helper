//
//  TPWebView.m
//  Helper
//
//  Created by Topredator on 2025/2/6.
//

#import "TPWebView.h"

@interface TPWebView () <WKNavigationDelegate, WKUIDelegate>

@end

@implementation TPWebView

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    if (!configuration) {
        configuration = [[WKWebViewConfiguration alloc] init];
        configuration.suppressesIncrementalRendering = YES;
        configuration.userContentController = [[WKUserContentController alloc] init];
    }
    if (self = [super initWithFrame:frame configuration:configuration]) {
        [self initialize];
    }
    return self;
}
- (void)initialize
{
    
    self.clipsToBounds = YES;
    self.opaque = NO;
    self.UIDelegate = self.tp_uiDelegate;
    self.navigationDelegate = self;
}
- (void)setTp_uiDelegate:(id<WKUIDelegate>)tp_uiDelegate {
    _tp_uiDelegate = tp_uiDelegate;
    self.UIDelegate = tp_uiDelegate;
}
#pragma mark - public function
//开始请求
- (void)startRequest {
    if (self.fileName) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:self.fileName withExtension:nil];
        [self loadFileURL:url allowingReadAccessToURL:url];
    } else {
        [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.curl]]];
    }
}
- (void)reload {
    [super reload];
}

- (void)setCurl:(NSString *)curl {
    _curl = curl;
}
#pragma mark - WKNavigationDelegate
//1.决定是否导航
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if ([self.tp_navDelegate respondsToSelector:@selector(tp_webView:decidePolicyForNavigationAction:decisionHandler:)]) {
        [self.tp_navDelegate tp_webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    } else {
        WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
        NSString *urlString = [navigationAction.request.URL absoluteString];
        urlString = [urlString stringByRemovingPercentEncoding];
        
        if ([urlString containsString:@"weixin://"]) {
            actionPolicy =WKNavigationActionPolicyCancel;
            //解决wkwebview weixin://无法打开微信客户端的处理
            NSURL *url = [NSURL URLWithString:urlString];
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {}];
            } else {
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                } else {
                    [TPUIToast showInfo:@"无法打开微信" inView:self];
                }
            }
        }
        decisionHandler(actionPolicy);
    }
}

//2.开始导航
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    if ([self.tp_navDelegate respondsToSelector:@selector(tp_webView:didStartProvisionalNavigation:)]) {
        [self.tp_navDelegate tp_webView:webView didStartProvisionalNavigation:navigation];
    } else {
        
    }
}

//3.接收到请求返回 决定是否继续接受网页内容
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    if ([self.tp_navDelegate respondsToSelector:@selector(tp_webView:decidePolicyForNavigationResponse:decisionHandler:)]) {
        [self.tp_navDelegate tp_webView:webView decidePolicyForNavigationResponse:navigationResponse decisionHandler:decisionHandler];
    } else {
        decisionHandler(WKNavigationResponsePolicyAllow);
    };
}

//4.确定开始接受网页内容
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    if ([self.tp_navDelegate respondsToSelector:@selector(tp_webView:didCommitNavigation:)]) {
        [self.tp_navDelegate tp_webView:webView didCommitNavigation:navigation];
    } else {
        
    }
}

//5.1加载网页内容结束
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    __weak typeof(self)weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakself.tp_navDelegate respondsToSelector:@selector(tp_webView:didFinishNavigation:)]) {
            [weakself.tp_navDelegate tp_webView:webView didFinishNavigation:navigation];
        } else {
            
        }
    });
}

//5.2加载网页内容失败
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
    if ([self.tp_navDelegate respondsToSelector:@selector(webView:didFailNavigation:withError:)]) {
        [self.tp_navDelegate tp_webView:webView didFailNavigation:navigation withError:error];
    } else {
        
    }
}


//接受到服务器重定向请求
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    if ([self.tp_navDelegate respondsToSelector:@selector(tp_webView:didReceiveServerRedirectForProvisionalNavigation:)]) {
        [self.tp_navDelegate tp_webView:webView didReceiveServerRedirectForProvisionalNavigation:navigation];
    } else {
        
    }
}
//重定向请求失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    if ([self.tp_navDelegate respondsToSelector:@selector(tp_webView:didFailProvisionalNavigation:withError:)]) {
        [self.tp_navDelegate tp_webView:webView didFailProvisionalNavigation:navigation withError:error];
    } else {
        
    }
}

//接受到鉴权请求
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    if ([self.tp_navDelegate respondsToSelector:@selector(tp_webView:didReceiveAuthenticationChallenge:completionHandler:)]) {
        [self.tp_navDelegate tp_webView:webView didReceiveAuthenticationChallenge:challenge completionHandler:completionHandler];
    } else {
        completionHandler(NSURLSessionAuthChallengeRejectProtectionSpace,nil);
    }
}
//文档加载过程中断
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    if ([self.tp_navDelegate respondsToSelector:@selector(tp_webViewWebContentProcessDidTerminate:)]) {
        [self.tp_navDelegate tp_webViewWebContentProcessDidTerminate:webView];
    } else {
        
    }
}


#pragma mark - 清理工作
- (void)clear
{
    [self stopLoading];
    [self.configuration.userContentController removeAllUserScripts];
    
}

- (void)dealloc
{
    [self clear];
}

@end
