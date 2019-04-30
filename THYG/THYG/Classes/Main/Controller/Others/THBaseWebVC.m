//
//  THBaseWebVC.m
//  THYG
//
//  Created by Mac on 2018/4/20.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseWebVC.h"

@interface THBaseWebVC () <UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation THBaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGColor;
    if (self.webHeight) {
        self.webView.height = self.webHeight;
    }
    [self.view addSubview:self.webView];
    
    [SVProgressHUD showWithStatus:@"正在努力加载中"];
    
    [self loadWebView];
}

- (void)loadWebView {
    if (self.webContent.length) {
        [self.webView loadHTMLString:[self fixImagesInHtmlString:self.webContent] baseURL:nil];
    } else if (self.url.length) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    } else {
        [SVProgressHUD showErrorWithStatus:@"网页内容不存在"];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

- (void)setIsDisableGestures:(BOOL)isDisableGestures {
    _isDisableGestures = isDisableGestures;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
}

- (UIWebView*)webView {
    if (_webView==nil) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNaviHeight)];
        _webView.backgroundColor = BGColor;
        _webView.delegate = self;
    }
    return _webView;
}

- (NSString *)fixImagesInHtmlString:(NSString *)string {
    return [NSString stringWithFormat:@"<html> \n"
            "<head> \n"
            "<style type=\"text/css\"> \n"
            "* {margin:0; padding:0;}\n"
            "img {width:100%%; height:auto; display:block;}\n"
            "</style> \n"
            "</head> \n"
            "<body>%@"
            "</body>"
            "</html>",string];
}

@end
