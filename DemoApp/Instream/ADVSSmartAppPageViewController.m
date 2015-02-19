//
//  ADVSSmartAppPageViewController.m
//  DemoApp
//
//  Created by M.T.Burn on 2014/04/18.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//
#import "ADVSSmartAppPageViewController.h"
#import "ADVSSmartAppScrollFeedView.h"
#import "ADVSSmartAppViewController.h"
#import "ADVSSmartAppColorPalette.h"
#import "ADVSSmartAppRssModelManager.h"
#import "ADVSSmartAppWebViewController.h"
#import "ADCubeTransition.h"
#import "ADTransitioningDelegate.h"

static const NSInteger MenuWidth  = 70;
static const NSInteger MenuHeight = 35;
static const int PageNum = 9;

@interface ADVSSmartAppPageViewController () <ADVSSmartAppScrollFeedViewDelegate, ADVSSmartAppScrollFeedViewDataSource>
@property (nonatomic) ADVSSmartAppScrollFeedView *feedView;
@property (nonatomic) id<UIViewControllerAnimatedTransitioning> animator;
@property (nonatomic) UIView *backgroundView;
@end

@implementation ADVSSmartAppPageViewController

#pragma mark - LifyCycle
- (void)loadView {
    self.view = self.feedView;
    self.navigationController.delegate = self;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y+MenuHeight, 360.0f, 5.0f)];
    [self.view addSubview:_backgroundView];
    
    [self changeBackGroundColor:0];
    
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Public
- (void)openUIWebView:(NSURL *)url
{
    ADVSSmartAppWebViewController *a = [[ADVSSmartAppWebViewController alloc] initWithUrl:url];
    [self.navigationController pushViewController:a animated:YES];
}

#pragma mark - Private
- (ADVSSmartAppScrollFeedView *)feedView {
    if (_feedView == nil) {
        self.feedView = [[ADVSSmartAppScrollFeedView alloc] initWithStyle:UIPageViewControllerTransitionStylePageCurl];
        _feedView.scrollFeedViewDataSource = self;
        _feedView.scrollFeedViewDelegate   = self;
    }
    return _feedView;
}

- (void)changeBackGroundColor:(int) index
{
    _backgroundView.backgroundColor = [ADVSSmartAppRssModelManager rssDictModel:[NSNumber numberWithInt:index]][@"color"];
    //self.view.backgroundColor = [ADVSSmartAppRssModelManager rssDictModel:[NSNumber numberWithInt:index]][@"color"];
    //[UINavigationBar appearance].barTintColor = [UIColor blackColor];
}

#pragma mark - ADVSSmartAppScrollFeedViewDataSource

- (NSInteger)numberOfPages:(ADVSSmartAppScrollFeedView *)scrollFeedView {
    return PageNum;
}

- (CGSize)sizeOfMenuView:(ADVSSmartAppScrollFeedView *)scrollFeedView {
    return CGSizeMake(MenuWidth, MenuHeight);
}

- (NSArray *)viewsForMenuView:(ADVSSmartAppScrollFeedView *)scrollFeedView {
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<PageNum; i++) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MenuWidth, MenuHeight)];
        
        UIBezierPath *uiBezierPath = [UIBezierPath bezierPathWithRoundedRect:v.bounds
                                                           byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                                 cornerRadii:CGSizeMake(5.f, 5.f)];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setPath:[uiBezierPath CGPath]];
        v.layer.mask      = shapeLayer;
        
        v.backgroundColor = [ADVSSmartAppRssModelManager rssDictModel:[NSNumber numberWithInt:i]][@"color"];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 10.0f, MenuWidth, MenuHeight-20.0f)];
        label.text = [ADVSSmartAppRssModelManager rssDictModel:[NSNumber numberWithInt:i]][@"label"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:14.0f];
        label.textColor = [UIColor whiteColor];
        label.adjustsFontSizeToFitWidth = YES;
        [v addSubview:label];
        
        [array addObject:v];
    }
    
    return [array copy];
}

- (NSArray *)viewsForFeedView:(ADVSSmartAppScrollFeedView *)scrollFeedView {
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<PageNum; i++) {
        ADVSSmartAppViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ADVSSmartViewController"];
        [vc view];
        vc.view.backgroundColor = [ADVSSmartAppRssModelManager rssDictModel:[NSNumber numberWithInt:i]][@"color"];
        vc.delegate = self;
        vc.confDict = [ADVSSmartAppRssModelManager rssDictModel:[NSNumber numberWithInt:i]];
        [vc bindToSdk];
        [vc startDownload];
                
        [array addObject:vc];
    }
    
    return [array copy];
}

#pragma mark - ADVSSmartAppScrollFeedViewDelegate

- (void)scrollFeedView:(ADVSSmartAppScrollFeedView *)scrollFeedView didChangeCurrentPage:(NSInteger)page {
    NSLog(@"ページ遷移Done. page: %d", (int)page);
    
    [self changeBackGroundColor:(int)page];
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    
    self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
    
    ADCubeTransition *transition = [[ADCubeTransition alloc] initWithDuration:0.5f
                                                                  orientation:ADTransitionRightToLeft
                                                                   sourceRect:self.view.bounds];
    
    _animator = [[ADTransitioningDelegate alloc] initWithTransition:transition];
    
    return _animator;
}

#pragma mark - Status bar hidden

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
