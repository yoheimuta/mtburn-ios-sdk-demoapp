//
//  Article1x3TableViewCell.h
//  SmartNewsSample
//
//  Created by M.T.Burn on 2014/04/15.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADVSSmartAppArticle1x3TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *leftFeed;
@property (weak, nonatomic) IBOutlet UITextView *rightTopFeed;
@property (weak, nonatomic) IBOutlet UITextView *rightMiddleFeed;
@property (weak, nonatomic) IBOutlet UITextView *rightBottomFeed;
@property (weak, nonatomic) IBOutlet UIImageView *feedImageView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightTopView;
@property (weak, nonatomic) IBOutlet UIView *rightMiddleView;
@property (weak, nonatomic) IBOutlet UIView *rightBottomView;

@end
