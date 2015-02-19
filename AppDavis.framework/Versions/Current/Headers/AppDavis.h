//
//  AppDavis.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2/10/14.
//  Copyright (c) 2014 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 `AppDavis` is entry point class for starting using AppDavis.framework.
 
 If you want use some of AppDavis function, write `initMedia` first of all.
 
 */

extern NSString *const ADVSParameterIconAdWidth;
extern NSString *const ADVSParameterIconAdHeight;
extern NSString *const ADVSParameterIconAdImgWidth;
extern NSString *const ADVSParameterIconAdImgHeight;
extern NSString *const ADVSParameterIconAdTextColor;
extern NSString *const ADVSParameterIconAdTextAlpha;
extern NSString *const ADVSParameterIconAdTextBgColor;
extern NSString *const ADVSParameterIconAdTextBgAlpha;
extern NSString *const ADVSParameterIconAdTextVisible;
extern NSString *const ADVSParameterIconAdTextWidth;
extern NSString *const ADVSParameterIconAdTextHeight;
extern NSString *const ADVSParameterIconAdTextPadding;
extern NSString *const ADVSParameterIconAdTextFontSize;
extern NSString *const ADVSParameterIconAdTextFontAjustWidth;

@interface AppDavis : NSObject

///------------------------------------
/// @name Initialize AppDavis task
///------------------------------------

/**
 Sets the given mediaId from administrator.
 You should describe this method in [AppDelegate -application:didFinishLaunchingWithOptions:]
 Unless you have specific requirements.
 
 @param mediaId The number which was given by administrator.
*/

+ (void)initMedia:(NSString *)mediaId;

+ (void)initMedia:(NSString *)mediaId params:(NSDictionary*)params;

@end
