//
//  ADVSInstreamAdCellTextOnly.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/05/27.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADVSInstreamAdCellProtocol.h"

@class ADVSInstreamInfoModel;

/**
 @see `ADVSInstreamAdCellProtocol`
 */

@interface ADVSInstreamAdCellTextOnly : UITableViewCell<ADVSInstreamAdCellProtocol>
+ (CGFloat)heightForCell;
- (void)updateCell:(ADVSInstreamInfoModel*)infoModel completion:(void (^)(NSError *error)) completion;
@end
