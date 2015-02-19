//
//  WebViewController.h
//  SmartNewsSample
//
//  Created by M.T.Burn on 2014/04/23.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADVSSmartAppWebViewController : UIViewController <UIWebViewDelegate>
- (id)initWithUrl:(NSURL *) url;
@end
