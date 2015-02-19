//
//  ADVSInstreamAppPageTabView.h
//  DemoApp
//
//  Created by M.T.Burn on 2014/05/21.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//

#import "ADVSInstreamAppPageTabView.h"

@implementation ADVSInstreamAppPageTabView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UINib *nib = [UINib nibWithNibName:@"ADVSInstreamAppPageTabView" bundle:nil];
        self = [nib instantiateWithOwner:nil options:nil][0];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
