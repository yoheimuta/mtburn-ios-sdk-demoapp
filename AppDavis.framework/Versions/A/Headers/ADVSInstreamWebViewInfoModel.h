//
//  ADVSInstreamWebViewInfoModel.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/04/17.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef ADVS_INSTREAMINFO_PROTOCOL_H
#define ADVS_INSTREAMINFO_PROTOCOL_H
@protocol ADVSInstreamInfoProtocol <NSObject>
@property (nonatomic, readonly) NSNumber *position;
@end
#endif

/**
 `ADVSInstreamWebViewInfoModel` is a container to be stored instream advertisement html.
 */

@interface ADVSInstreamWebViewInfoModel : NSObject<ADVSInstreamInfoProtocol>

/**
 advertisement html to be consisted of ~4096 characters in double byte character
 (it's not a fixed specification. see our information webpage to get the latest specification)
 */
@property (nonatomic, readonly) NSString *html;

/**
 advertisement webview width. The value of 0 mean device size width.
 ex. If width is 160.0f, your webview width is set 160.0f. If width is 0 and device is iphone, webview width is set 320.0f.
 (it's not a fixed specification. see our information webpage to get the latest specification)
 */
@property (nonatomic, readonly) CGFloat width;

/**
 advertisement webview height. Equal to or less than zero value is invalid
 (it's not a fixed specification. see our information webpage to get the latest specification)
 */
@property (nonatomic, readonly) CGFloat height;

/**
 advertisement position to be put in the tableView.
 it is used by advertising performance analysis.
 */
@property (nonatomic, readonly) NSNumber *position;

@end