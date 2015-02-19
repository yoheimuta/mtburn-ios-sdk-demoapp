//
//  ADVSInstreamAppPageController.h
//  DemoApp
//
//  Created by M.T.Burn on 2014/05/21.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//

#import "ADVSInstreamAppPageController.h"
#import <AppDavis/ADVSInstreamAdCellThumbnailSmall.h>
#import <AppDavis/ADVSInstreamAdCellThumbnailMiddle.h>
#import <AppDavis/ADVSInstreamAdCellLandscapePhoto.h>
#import <AppDavis/ADVSInstreamAdCellPhotoBottom.h>
#import <AppDavis/ADVSInstreamAdCellPhotoMiddle.h>
#import <AppDavis/ADVSInstreamAdCellTextOnly.h>
#import <AppDavis/ADVSInstreamAdCellWebView.h>
#import "ADVSInstreamAppTableViewController.h"
#import "ADVSInstreamAppPageTabView.h"

@interface ADVSInstreamAppPageController ()

@end

@implementation ADVSInstreamAppPageController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    /*
    self.title = @"InstreamAds";
    self.navigationController.navigationBarHidden = NO;
     */
    self.dataSource = self;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager
{
    // タブの数
    return 9;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index
{
    ADVSInstreamAppPageTabView *view = [ADVSInstreamAppPageTabView new];
    switch (index) {
        case 1:
            view.tabLabel.text = @"ThumbnailSmall";
            [view.iconImageView setImage:[UIImage imageNamed:@"icon1.png"]];
            break;
        case 2:
            view.tabLabel.text = @"LandscapePhoto";
            [view.iconImageView setImage:[UIImage imageNamed:@"icon2.png"]];
            break;
        case 3:
            view.tabLabel.text = @"PhotoBottom";
            [view.iconImageView setImage:[UIImage imageNamed:@"icon3.png"]];
            break;
        case 4:
            view.tabLabel.text = @"PhotoMiddle";
            [view.iconImageView setImage:[UIImage imageNamed:@"icon1.png"]];
            break;
        case 5:
            view.tabLabel.text = @"TextOnly";
            [view.iconImageView setImage:[UIImage imageNamed:@"icon2.png"]];
            break;
        case 6:
            view.tabLabel.text = @"WebViewTextOnly";
            [view.iconImageView setImage:[UIImage imageNamed:@"icon3.png"]];
            break;
        case 7:
            view.tabLabel.text = @"WebViewLandscape";
            [view.iconImageView setImage:[UIImage imageNamed:@"icon1.png"]];
            break;
        case 8:
            view.tabLabel.text = @"WebViewPhotoBottom";
            [view.iconImageView setImage:[UIImage imageNamed:@"icon2.png"]];
            break;
        default:
            break;
    }
    return view;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    ADVSInstreamAppTableViewController* contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ADVSInstreamAppTableViewController"];
    
    Class adCellClass = [ADVSInstreamAdCellThumbnailMiddle class];
    switch (index) {
        case 1:
            adCellClass = [ADVSInstreamAdCellThumbnailSmall class];
            break;
        case 2:
            adCellClass = [ADVSInstreamAdCellLandscapePhoto class];
            break;
        case 3:
            adCellClass = [ADVSInstreamAdCellPhotoBottom class];
            break;
        case 4:
            adCellClass = [ADVSInstreamAdCellPhotoMiddle class];
            break;
        case 5:
            adCellClass = [ADVSInstreamAdCellTextOnly class];
            break;
        case 6:
            adCellClass = [ADVSInstreamAdCellWebView class];
            break;
        case 7:
            adCellClass = [ADVSInstreamAdCellWebView class];
            break;
        case 8:
            adCellClass = [ADVSInstreamAdCellWebView class];
            break;
        default:
            break;
    }
    
    [contentViewController setupAdCell:adCellClass index:index];
    return contentViewController;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
        case ViewPagerOptionTabHeight:
            return 40.0;
        case ViewPagerOptionTabOffset:
            return 80.0;
        case ViewPagerOptionTabWidth:
            //return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0;
            return 160.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 1.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 1.0;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            return [UIColor whiteColor];
        case ViewPagerContent:
            return [UIColor whiteColor];
        default:
            return color;
    }
}

- (UIColor *)viewPager:(ViewPagerController *)viewPager indicatorColorForTabAtIndex:(NSUInteger)index
{
    UIColor *color = [[UIColor redColor] colorWithAlphaComponent:0.64];
    switch (index) {
        case 1:
            color = [UIColor blueColor];
            break;
        case 2:
            color = [UIColor greenColor];
            break;
        default:
            break;
    }
    return color;
}

@end
