//
//  ADVSIconAdLoader.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2/18/14.
//  Copyright (c) 2014 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADVSIconAdView.h"
#import "ADVSIconAdLoaderDelegate.h"

/**
 `ADVSIconAdLoader` is for loading Icon type advertisement.
 if you want to do so,
 
 1. instantiate this class.
 2. create `ADVSIconAdView` you want to display.
 3. add `ADVSIconAdView` to this instance.
 4. call - loadAd
 
 That's it!
 */

@interface ADVSIconAdLoader : NSObject

/**
 This delegate tells loading icon advertisement results.
 
 @see ADVSIconAdLoaderDelegate.h
 */

@property (nonatomic, weak) id<ADVSIconAdLoaderDelegate> delegate;

/**
 Refreshing icon advertisement interval.
 
 Default value is 30.0.
 
 Allows value 30.0 <= refreshInterval <= 120.0.
 */

@property (nonatomic) NSTimeInterval refreshInterval;

/**
 Added icon views auto refreshing flag.
 
 Default value is YES.
 
 If set NO, loader doesn't refresh automatically even if set refreshInterval.
 */

@property (nonatomic) BOOL autoRefreshingEnabled;

/**
 class method returns max `ADVSIconAdView` count for adding this instance.
 */

+ (NSUInteger)maxIconLoadCount;

/**
 add `ADVSIconAdView` instance you want to load advertisement.
 
 @param iconAdView iconAdView for loading icon advertisement.
 
 @see ADVSIconAdView.h
 */

- (void)addIconAdView:(ADVSIconAdView *)iconAdView;

/**
 add `ADVSIconAdView` instances you want to load advertisement.
 
 @param iconAdViews iconAdViews for loading icon advertisement.
 
 @see -addIconAdView:
 @see ADVSIconAdView.h
 */

- (void)addIconAdViews:(NSArray *)iconAdViews;

/**
 remove `ADVSIconAdView` instance you want to remove for loading advertisement target.
 
 @param iconAdView iconAdViews for removing target.
 
 @see -addIconAdView:
 @see ADVSIconAdView.h
 */

- (void)removeIconAdView:(ADVSIconAdView *)iconAdView;

/**
 count of `ADVSIconAdView` instances you added.
 
 @see +maxIconLoadCount
 */

- (NSUInteger)iconAdViewCount;

/**
 start loading advertisements for added `ADVSIconAdView` instances.
 */

- (void)loadAd;

/**
 
 */

- (void)pause;

/**
 
 */

- (void)resume;

@end
