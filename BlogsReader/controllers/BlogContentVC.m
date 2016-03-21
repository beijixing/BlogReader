//
//  ViewController.m
//  BlogsReader
//
//  Created by ybon on 16/2/26.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "BlogContentVC.h"
#import "MBProgressHUD.h"

@interface BlogContentVC ()<UIWebViewDelegate, UIScrollViewDelegate>
{
    UIWebView *_webView;
    UIToolbar *_tollBar;
    float _contentOffsetY;
}
@property (nonatomic,assign) int oldState;
@end

@implementation BlogContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    typeof (self) __weak weakSef = self;
    [self setLeftNavigationBarButtonItemWithImage:@"icon_left" andAction:^{
        [weakSef.navigationController popViewControllerAnimated:YES];
    }];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.netAddress]];
    [_webView loadRequest:request];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    [self.view addSubview:_webView];
    
    _tollBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 64 - 49, self.view.frame.size.width, 49)];
    _tollBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:_tollBar];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_left"] style:UIBarButtonItemStylePlain target:self action:@selector(webViewGoBack:)];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_right"] style:UIBarButtonItemStylePlain target:self action:@selector(webViewGoForward:)];
    _tollBar.items = [NSArray arrayWithObjects:leftButton, rightButton, nil];
    
    _oldState = 0;
}

- (void)webViewGoBack:(id)sender {
    if (_webView.canGoBack) {
        [_webView goBack];
    }
}

- (void)webViewGoForward:(id)sender {
    if (_webView.canGoForward) {
        [_webView goForward];
    }
}


#pragma mark --WebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (_webView.canGoBack || _webView.canGoForward) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    _contentOffsetY = webView.scrollView.contentOffset.y;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark --ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll");
    NSLog(@"scrollView.contentOffset.y = %f", scrollView.contentOffset.y);
    
    
    int  toolBarState = 0;
    if (scrollView.contentOffset.y - _contentOffsetY > 50) {
        toolBarState = 1;
    }else if (scrollView.contentOffset.y - _contentOffsetY < 50){
        toolBarState = 2;
    }
    
    if (self.oldState == toolBarState)
    {
        return;
    }
    self.oldState = toolBarState;
    if (toolBarState == 1) {
        [self hideToolBarAndNavigationBar];
    }else if (toolBarState == 2) {
        [self showToolBarAndNavigationBar];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _contentOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"scrollViewWillEndDragging");
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    NSLog(@"scrollViewDidEndZooming");
    
}

- (void)showToolBarAndNavigationBar {
    self.navigationController.navigationBarHidden = NO;
    _tollBar.hidden = NO;
}

- (void)hideToolBarAndNavigationBar {
    self.navigationController.navigationBarHidden = YES;
    _tollBar.hidden = YES;
}
@end
