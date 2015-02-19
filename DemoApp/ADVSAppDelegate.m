//
//  ADVSAppDelegate.m
//  DemoApp
//
//  Created by M.T.Burn on 2/11/14.
//  Copyright (c) 2014 M.T.Burn. All rights reserved.
//

#import "ADVSAppDelegate.h"
#import <AppDavis/AppDavis.h>

static int media_id = 2;

@implementation ADVSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AppDavis initMedia:[NSString stringWithFormat:@"%d", media_id]];
    /*
     [AppDavis initMedia:@"2" params:@{ADVSParameterIconAdWidth: @75.0f,
                                      ADVSParameterIconAdHeight: @75.0f,
                                      ADVSParameterIconAdImgWidth: @50.0f,
                                      ADVSParameterIconAdImgHeight: @50.0f,
                                      ADVSParameterIconAdTextColor: @"ff0000",
                                      ADVSParameterIconAdTextAlpha: @1.0f,
                                      ADVSParameterIconAdTextBgColor: @"ffffff",
                                      ADVSParameterIconAdTextBgAlpha: @1.0f,
                                      ADVSParameterIconAdTextVisible: @"1",
                                      ADVSParameterIconAdTextFontSize: @10.4f,
                                      ADVSParameterIconAdTextWidth: @50.0f,
                                      ADVSParameterIconAdTextHeight: @13.0f,
                                      ADVSParameterIconAdTextPadding: @10.0f,
                                      ADVSParameterIconAdTextFontAjustWidth: @"0",
                                      }];
     */
    return YES;
}

- (NSDictionary*)adspotIdDict
{
    // instream key の value は visual_id 0, 1, 2, 3, 4, 5, 6 に対応する adspot_id を array で持つ
    // custom_instream key の value は ad_type 5, 6, 7 に対応する adspot_id と ad_type 5, 6, 7 の html に対応する adspot_id を array で持つ
    switch (media_id) {
        // test use
        default:
        case 1:
            return @{@"instream": @[@"NDgzOjE", @"Njc4OjI", @"NzA3OjM", @"MTY5OjQ", @"OTMzOjU", @"MzUxOjk", @"OTgxOjUy", @"MjQxOjUz", @"NjA0OjU0"],
                     @"custom_instream": @[@"NDgzOjE", @"NzA3OjM", @"MTY5OjQ", @"OTgxOjUy", @"MjQxOjUz", @"NjA0OjU0"],
                     @"interstitial": @"TEMP"};
            break;
        case 2:
            return @{@"instream": @[@"NDQ0OjMx", @"OTA2OjMy", @"ODEzOjMz", @"OTIyOjM0", @"NzA2OjM1", @"MzA3OjM2", @"MTI2OjU1", @"OTkzOjU2", @"MzEzOjU3"],
                     @"custom_instream": @[@"NDQ0OjMx", @"ODEzOjMz", @"OTIyOjM0", @"MTI2OjU1", @"OTkzOjU2", @"MzEzOjU3"],
                     @"interstitial": @"TEMP"};
            break;
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
