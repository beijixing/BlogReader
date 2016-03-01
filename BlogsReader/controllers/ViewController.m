//
//  ViewController.m
//  BlogsReader
//
//  Created by ybon on 16/2/26.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://suenblog.duapp.com"]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    UIToolbar *tollBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
    tollBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:tollBar];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_left"] style:UIBarButtonItemStylePlain target:self action:@selector(webViewGoBack:)];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_right"] style:UIBarButtonItemStylePlain target:self action:@selector(webViewGoForward:)];
    tollBar.items = [NSArray arrayWithObjects:leftButton, rightButton, nil];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
