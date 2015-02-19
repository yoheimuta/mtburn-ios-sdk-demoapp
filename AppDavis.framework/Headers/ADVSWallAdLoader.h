//
//  ADVSWallAdLoader.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2/19/14.
//  Copyright (c) 2014 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADVSWallAdLoaderDelegate.h"

/**
 `ADVSWallAdLoader` is for loading Wall type advertisement.
 if you want to do so, instantiate this class and call -loadAd.
 That's it!
 */

@interface ADVSWallAdLoader : NSObject

/**
 This delegate tells loading wall advertisement results.
 
 @see ADVSWallAdLoaderDelegate.h
 */

@property (nonatomic, weak) id<ADVSWallAdLoaderDelegate> delegate;



/**
 Loads a wall type advertisement instantly.
 If you want to know results of loading, should get delegation.
 
 @see ADVSWallAdLoaderDelegate.h
 */

- (void)loadAd;


/**
 Notify application domain impression to AppDavis server.
 */

- (void)notifyAppImp;

/**
 Request Wall Lead Image
 */

- (void)requestWallLead:(NSString *)wallLeadId;

/**
 Clear cache of previous Wall Lead request.
 */

- (void)clearWallLeadCache;

@end
