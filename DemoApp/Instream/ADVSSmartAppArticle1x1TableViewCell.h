//
//  Article1x1TableViewCell.h
//  SmartNewsSample
//
//  Created by M.T.Burn on 2014/04/15.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADVSSmartAppArticle1x1TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *leftFeed;
@property (weak, nonatomic) IBOutlet UITextView *rightFeed;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@end
