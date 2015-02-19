//
//  ADVSInterstitialViewController.m
//  DemoApp
//
//  Created by M.T.Burn on 2014/10/17.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//

#import "ADVSInterstitialViewController.h"
#import <AppDavis/ADVSInterstitialAdLoader.h>

@interface ADVSInterstitialViewController () <ADVSInterstitialAdLoaderDelegate>
@property (nonatomic) ADVSInterstitialAdLoader *interstitialAdLoader;
@end

@implementation ADVSInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interstitialAdLoader = [ADVSInterstitialAdLoader new];
    self.interstitialAdLoader.delegate = self;
    [self.interstitialAdLoader loadRequest];
}

#pragma mark - ADVSInterstitialAdLoaderDelegate

- (void)interstitialAdLoaderDidStartLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidStartLoadingAd");
}

- (void)interstitialAdLoaderDidFinishLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidFinishLoadingAd");
}

- (void)interstitialAdLoaderDidFinishLoadingAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidFinishLoadingAdView");
    [self.interstitialAdLoader displayAd];
}

- (void)interstitialAdLoaderDidSkipLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidSkipLoadingAd");
}

- (void)interstitialAdLoaderDidClickIntersititialAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidClickIntersititialAdView:");
}

- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdWithError:(NSError *)error
{
    NSLog(@"interstitialAdLoader:didFailToLoadAdWithError:%@", error);
}

- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdViewWithError:(NSError *)error
{
    NSLog(@"interstitialAdLoader:didFailToLoadAdViewWithError:%@", error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
