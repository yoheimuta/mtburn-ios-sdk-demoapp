//
//  ADVSInstreamInfoModel.h
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
 `ADVSInstreamInfoModel` is a container to be stored instream advertisement information.
 */

@interface ADVSInstreamInfoModel : NSObject<ADVSInstreamInfoProtocol>

/**
 advertisement title to be consisted of ~20 characters in double byte character
 (it's not a fixed specification. see our information webpage to get the latest specification)
 */
@property (nonatomic, readonly) NSString *title;

/**
 advertisement text to be consisted of 40~70 characters in double byte character
 (it's not a fixed specification. see our information webpage to get the latest specification)
 */
@property (nonatomic, readonly) NSString *content;

/**
 advertisement position to be put in the tableView.
 it is used by advertising performance analysis.
 */
@property (nonatomic, readonly) NSNumber *position;

/**
 advertiser name to be put in the tableView.
 it is used to show that this content is provided for PR.
 */
@property (nonatomic, readonly) NSString *displayedAdvertiser;

/**
 starts loading advertisement icon image for assigning a UIImage to the iconImageView,
 if you want to do so.
 
 @param iconImageView  `UIImageView` instance to be assigned the icon image
 @param completion     callback block to inform an error. If the error is nil and loadImage:completion is also completed, invoke measureImp API.
 
 @see ADVSInstreamAdLoader.h
 */

- (void)loadIconImage:(UIImageView*)iconImageView completion:(void (^)(NSError *error)) completion;

/**
 starts loading advertisement main image for assigning a UIImage to the imageView,
 if you want to do so.
 
 @param imageView   `UIImageView` instance to be assigned the main image
 @param completion  callback block to inform an error. If the error is nil and loadIconImage:completion is also completed, invoke measureImp API.
 
 @see ADVSInstreamAdLoader.h
 */

- (void)loadImage:(UIImageView*)imageView completion:(void (^)(NSError *error)) completion;
@end
