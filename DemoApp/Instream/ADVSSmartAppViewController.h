//
//  ADVSSmartViewController.h
//  DemoApp
//
//  Created by M.T.Burn on 2014/04/17.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADVSSmartAppPageViewController.h"

@interface ADVSSmartAppViewController : UITableViewController
@property(nonatomic) NSDictionary *confDict;
@property(nonatomic) ADVSSmartAppPageViewController* delegate;
- (void)bindToSdk;
- (void)startDownload;
@end
