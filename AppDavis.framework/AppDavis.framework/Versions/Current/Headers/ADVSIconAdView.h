//
//  ADVSIconAdView.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2/18/14.
//  Copyright (c) 2014 M.T.Burn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 `ADVSIconAdView` is subclass of `UIView`.
 So, you can use this almost like `UIView`.
 
 This class displays two contents.
 
 1. Icon image
 2. Icon title
 
 @warning You can not create this view smaller than +iconViewDefaultSize
 */

@interface ADVSIconAdView : UIView

/**
 returns `ADVSIconAdView` default size.
 This size apply when you don't specify frame when initialize.
 
 @warning You can not create this view smaller than +iconViewDefaultSize
 */

+ (CGSize)iconViewDefaultSize;

/**
 Change Icon title text color.
 
 @param textColor Icon title text color.
 */

- (void)setTitleTextColor:(UIColor *)textColor;

@end
