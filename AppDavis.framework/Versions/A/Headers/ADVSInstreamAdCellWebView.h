//
//  ADVSInstreamAdCellWebView.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/07/16.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADVSInstreamAdCellProtocol.h"

@class ADVSInstreamWebViewInfoModel;

/**
 @see `ADVSInstreamAdCellInternalProtocol`
 */

@interface ADVSInstreamAdCellWebView : UITableViewCell<ADVSInstreamAdCellInternalProtocol>

- (void)updateCell:(ADVSInstreamWebViewInfoModel*)infoModel completion:(void (^)(NSError *error)) completion;

@end
