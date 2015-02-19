//
//  ADVSIconAdLoaderDelegate.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2/18/14.
//  Copyright (c) 2014 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `ADVSIconAdLoaderDelegate` is delegate protocol for getting loading Icon advertisement result.
 */

@class ADVSIconAdLoader;
@class ADVSIconAdView;

@protocol ADVSIconAdLoaderDelegate <NSObject>

/**
 Tells event just starting icon advertisement.
 
 @param iconAdLoader Object which is loading icon advertisement.
 */

- (void)iconAdLoaderDidStartLoadingAd:(ADVSIconAdLoader *)iconAdLoader;

/**
 Tells event just finishing icon advertisement.
 
 @param iconAdLoader Object which is loading icon advertisement.
 */

- (void)iconAdLoaderDidFinishLoadingAd:(ADVSIconAdLoader *)iconAdLoader;

/**
 Tells event just failed to display icon advertisement.
 
 @param wallAdLoader Object which tried to load icon advertisement.
 @param error NSError instance.
 */

- (void)iconAdLoader:(ADVSIconAdLoader *)iconAdLoader didFailToLoadAdWithError:(NSError *)error;

/**
 Tells event finished displaying each `ADVSIconAdView` instances.
 
 @param iconAdLoader Object which is loading icon advertisement.
 @param iconAdView `ADVSIconAdView` instance which finished displaying.
 */

- (void)iconAdLoader:(ADVSIconAdLoader *)iconAdLoader didReceiveIconAdView:(ADVSIconAdView *)iconAdView;

/**
 Tells event failed to display each `ADVSIconAdView` instances.
 
 @param iconAdLoader Object which is loading icon advertisement.
 @param iconAdView `ADVSIconAdView` instance which failed to  display.
 */

- (void)iconAdLoader:(ADVSIconAdLoader *)iconAdLoader didFailToReceiveIconAdView:(ADVSIconAdView *)iconAdView;

/**
 Tells event which clicked `ADVSIconAdView` instances.
 
 @param iconAdLoader Object which is loading icon advertisement.
 @param iconAdView `ADVSIconAdView` instance which clicked.
 */

- (void)iconAdLoader:(ADVSIconAdLoader *)iconAdLoader didClickIconAdView:(ADVSIconAdView *)iconAdView;

@end
