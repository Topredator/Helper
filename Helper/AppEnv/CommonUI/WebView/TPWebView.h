//
//  TPWebView.h
//  Helper
//
//  Created by Topredator on 2025/2/6.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

//所有WKNavigationDelegate中的方法这里都做了转接
//
@protocol TPWebViewNavigationDelegate <NSObject>
@optional
//1.决定是否导航
- (void)tp_webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
//2.开始导航
- (void)tp_webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//3.接收到请求返回 决定是否继续接受网页内容
- (void)tp_webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
//4.确定开始接受网页内容
- (void)tp_webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;
//5.1加载网页内容结束
- (void)tp_webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;
//5.2加载网页内容失败
- (void)tp_webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//接受到服务器重定向请求
- (void)tp_webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//重定向请求失败
- (void)tp_webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//接受到鉴权请求
- (void)tp_webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;
//文档加载过程中断
- (void)tp_webViewWebContentProcessDidTerminate:(WKWebView *)webView;
@end

@interface TPWebView : WKWebView
@property (nonatomic, weak) id<TPWebViewNavigationDelegate> tp_navDelegate;
@property (nonatomic, weak) id<WKUIDelegate> tp_uiDelegate;
/// 本地文件名称
@property (nonatomic, copy) NSString *fileName;
/// 链接地址
@property (nonatomic, copy) NSString *curl;

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration * __nullable)configuration;

- (void)startRequest;

- (void)reload;

- (void)clear;
@end
NS_ASSUME_NONNULL_END

