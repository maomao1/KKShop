//
//  THHelpCenterDetailCtl.m
//  THYG
//
//  Created by Colin on 2018/4/8.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHelpCenterDetailCtl.h"

@interface THHelpCenterDetailCtl ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation THHelpCenterDetailCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
}


@end
