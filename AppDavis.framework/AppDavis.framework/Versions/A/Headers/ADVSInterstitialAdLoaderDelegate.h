//
//  ADVSInterstitialAdLoaderDelegate.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/03/19.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `ADVSinterstitialAdLoaderDelegate` is delegate protocol for getting loading Interstitial advertisement result.
 */

@class ADVSInterstitialAdLoader;

@protocol ADVSInterstitialAdLoaderDelegate <NSObject>

- (void)interstitialAdLoaderDidStartLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader;
- (void)interstitialAdLoaderDidFinishLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader;
- (void)interstitialAdLoaderDidFinishLoadingAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader;
- (void)interstitialAdLoaderDidSkipLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader;
- (void)interstitialAdLoaderDidClickIntersititialAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader;
- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdWithError:(NSError *)error;
- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdViewWithError:(NSError *)error;
@end