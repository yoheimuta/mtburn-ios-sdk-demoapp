//
//  ADVSWallAdLoaderDelegate.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2/19/14.
//  Copyright (c) 2014 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `ADVSWallAdLoaderDelegate` is delegate protocol for getting loading Wall advertisement result.
 */


@class ADVSWallAdLoader;

@protocol ADVSWallAdLoaderDelegate <NSObject>

/**
 Tells event just before presenting wall advertisement.
 
 @param wallAdLoader Object which is loading wall advertisement.
 */

- (void)wallAdLoaderWillPresentWallAdView:(ADVSWallAdLoader *)wallAdLoader;


/**
 Tells event just after presenting wall advertisement.
 
 @param wallAdLoader Object which loaded wall advertisement.
 */

- (void)wallAdLoaderDidPresentWallAdView:(ADVSWallAdLoader *)wallAdLoader;


/**
 Tells event just before dismissing wall advertisement.
 
 @param wallAdLoader Object which loaded wall advertisement.
 */

- (void)wallAdLoaderWillDismissWallAdView:(ADVSWallAdLoader *)wallAdLoader;


/**
 Tells event just after dismissing wall advertisement.
 
 @param wallAdLoader Object which loaded wall advertisement.
 */

- (void)wallAdLoaderDidDismissWallAdView:(ADVSWallAdLoader *)wallAdLoader;

/**
 Tells event which wall ad loading failed.
 
 @param wallAdLoader Object which requested.
 */

- (void)wallAdLoader:(ADVSWallAdLoader *)wallAdLoader didFailToLoadAdWithError:(NSError *)error;

/**
 Tells event which notifying application impression succeed.
 
 @param wallAdLoader Object which requested.
 */

- (void)wallAdLoaderDidFinishNotifyingApp:(ADVSWallAdLoader *)wallAdLoader;

/**
 Tells event which notifying application impression failed.
 
 @param wallAdLoader Object which requested.
 */

- (void)wallAdLoader:(ADVSWallAdLoader *)wallAdLoader didFailToNotifyAppImpWithError:(NSError *)error;

/**
 Tells event just after wall lead image is fetched.

 @param wallAdLoader Object which is requested wall lead image.
 */

- (void)wallAdLoaderDidGetWallLead:(ADVSWallAdLoader *)wallAdLoader imageURL:(NSURL *)imageURL width:(NSInteger)width height:(NSInteger)height;

/**
 Tells event wihch failed to fetch wall lead image.

 @param wallAdLoader Object which requested.
 */

- (void)wallAdLoader:(ADVSWallAdLoader *)wallAdLoader didFailToRequestWallLeadWithError:(NSError *)error;

@end
