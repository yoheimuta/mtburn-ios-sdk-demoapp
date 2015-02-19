//
//  ADVSInstreamAdCellProtocol.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/04/21.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADVSInstreamInfoModel;

/**
 `ADVSInstreamAdCellInternalProtocol` is a protocol to be used by sdk internal
 Ignore it.
 */

@protocol ADVSInstreamAdCellInternalProtocol <NSObject>
@end

/**
 `ADVSInstreamAdCellProtocol` is a protocol to be conformed by sdk's defalut advertisement cell format objects.
 Use it, if you want to do so.
 */

@protocol ADVSInstreamAdCellProtocol <ADVSInstreamAdCellInternalProtocol>

/**
 required height for the advertisement cell format to be displayed
 */

+ (CGFloat)heightForCell;

/**
 update the advertisement cell object with using `ADVSInstreamInfoModel` instance.
 
 @param infoModel   `ADVSInstreamInfoModel` instance to be used
 @param completion  callback block to inform an error and the completion event. If the error is nil, invoke measureImp API.
 
 @see ADVSInstreamAdLoader.h
 */

- (void)updateCell:(ADVSInstreamInfoModel*)infoModel completion:(void (^)(NSError *error)) completion;
@end