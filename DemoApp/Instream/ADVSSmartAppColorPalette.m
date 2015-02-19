//
//  ADVSSmartAppColorPalette.m
//  DemoApp
//
//  Created by M.T.Burn on 2014/04/18.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//
#import "ADVSSmartAppColorPalette.h"

@implementation ADVSSmartAppColorPalette

+ (UIColor *)colorWithIndex:(NSInteger)index {
    return [UIColor colorWithRed:0.6-index*30/255.0 green:0.4+index*15/255.0 blue:0.3+index*30/255.0 alpha:1.0];
}

@end
