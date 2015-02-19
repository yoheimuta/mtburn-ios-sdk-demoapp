//
//  WebViewController.m
//  SmartNewsSample
//
//  Created by M.T.Burn on 2014/04/23.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import "ADVSSmartAppWebViewController.h"

@interface ADVSSmartAppWebViewController ()
@property(nonatomic) NSURL *url;
@end

@implementation ADVSSmartAppWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithUrl:(NSURL *) url
{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Web";
	
    NSAssert(_url, @"Not Found url");
    if (!_url) {
        return;
    }
    
    CGRect rect = self.view.frame;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:rect];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)webViewDidStartLoad:(UIWebView*)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
