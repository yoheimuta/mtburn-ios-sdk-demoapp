//
//  ADVSViewController.m
//  DemoApp
//
//  Created by M.T.Burn on 2/11/14.
//  Copyright (c) 2014 M.T.Burn. All rights reserved.
//

#import "ADVSViewController.h"
#import "ADVSAppDelegate.h"
#import <AppDavis/AppDavis.h>
#import <AppDavis/ADVSIconAdLoader.h>
#import <AppDavis/ADVSIconAdView.h>
#import <AppDavis/ADVSWallAdLoader.h>
#import <AppDavis/ADVSInterstitialAdLoader.h>

@interface ADVSViewController () <ADVSInterstitialAdLoaderDelegate, ADVSIconAdLoaderDelegate, ADVSWallAdLoaderDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) ADVSInterstitialAdLoader *interstitialAdLoader;
@property (nonatomic) ADVSIconAdLoader *iconAdLoader;
@property (nonatomic) NSMutableArray *iconAdViews;
@property (nonatomic) ADVSWallAdLoader *wallAdLoader;
@end

@implementation ADVSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.interstitialAdLoader = [ADVSInterstitialAdLoader new];
    self.interstitialAdLoader.delegate = self;
    self.interstitialAdLoader.adSpotId = [self interstitialAdSpotId];
    
    NSUInteger iconCount = 6;
    self.iconAdViews = [[NSMutableArray alloc] initWithCapacity:iconCount];
    self.iconAdLoader = [ADVSIconAdLoader new];
    self.iconAdLoader.delegate = self;
    
    self.wallAdLoader = [ADVSWallAdLoader new];
    self.wallAdLoader.delegate = self;

    // set default icon ads
    ADVSIconAdView *iconAdView1 = [ADVSIconAdView new];
    [self.view addSubview:iconAdView1];
    [self.iconAdViews addObject:iconAdView1];
    [self.iconAdLoader addIconAdView:iconAdView1];
    ADVSIconAdView *iconAdView2 = [ADVSIconAdView new];
    [self.view addSubview:iconAdView2];
    [self.iconAdViews addObject:iconAdView2];
    [self.iconAdLoader addIconAdView:iconAdView2];
    ADVSIconAdView *iconAdView3 = [ADVSIconAdView new];
    [self.view addSubview:iconAdView3];
    [self.iconAdViews addObject:iconAdView3];
    [self.iconAdLoader addIconAdView:iconAdView3];
    ADVSIconAdView *iconAdView4 = [ADVSIconAdView new];
    [self.view addSubview:iconAdView4];
    [self.iconAdViews addObject:iconAdView4];
    [self.iconAdLoader addIconAdView:iconAdView4];
    [self layoutIconAdViews];

    [self.iconAdLoader loadAd];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutIconAdViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action

- (IBAction)wallButtonTapped:(id)sender
{
    [self.wallAdLoader loadAd];
}

- (IBAction)notifyAppImpButtonTapped:(id)sender
{
    [self.activityIndicator startAnimating];
    [self.wallAdLoader notifyAppImp];
}

- (IBAction)iconButtonTapped:(id)sender
{
    ADVSIconAdView *iconAdView = [ADVSIconAdView new];
    [self.view addSubview:iconAdView];
    [self.iconAdViews addObject:iconAdView];
    [self.iconAdLoader addIconAdView:iconAdView];
    [self.iconAdLoader loadAd];
    
    [self layoutIconAdViews];
}
- (IBAction)autoRefreshSwitchTapped:(UISwitch *)sender
{
    self.iconAdLoader.autoRefreshingEnabled = sender.isOn;
}

- (IBAction)interstitialButtonTapped:(id)sender
{
    // if you want to display interstitial ad when the button tapped, delete this comment out and edit storyboard
    //[self.interstitialAdLoader loadRequest];
}

- (IBAction)requestWallLeadButtonTapped:(id)sender {
    [self.activityIndicator startAnimating];
    [self.wallAdLoader requestWallLead:@"999"];
}

#pragma mark - Private

- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)layoutIconAdViews
{
    CGSize defaultIconSize = [ADVSIconAdView iconViewDefaultSize];
    NSUInteger columnCount = 4;
    CGFloat horizontalPadding = (CGRectGetWidth(self.view.bounds) - defaultIconSize.width * columnCount) / (columnCount + 1);
    CGFloat verticalPadding = 100.0;
    
    [self.iconAdViews enumerateObjectsUsingBlock:^(ADVSIconAdView *iconAdView, NSUInteger idx, BOOL *stop) {
        NSInteger currentColumn = idx % columnCount;
        NSInteger currentRow = idx / columnCount;
        CGRect iconFrame = iconAdView.frame;
        iconFrame.origin.x = defaultIconSize.width * currentColumn + horizontalPadding * (currentColumn + 1);
        iconFrame.origin.y = CGRectGetHeight(self.view.bounds) - defaultIconSize.height - verticalPadding * currentRow;
        iconAdView.frame = iconFrame;
    }];
}

- (NSString *)interstitialAdSpotId
{
    ADVSAppDelegate *delegate = (ADVSAppDelegate *) [[UIApplication sharedApplication] delegate];
    return [delegate adspotIdDict][@"interstitial"];
}

#pragma mark - ADVSInterstitialAdLoaderDelegate

- (void)interstitialAdLoaderDidStartLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidStartLoadingAd");
}

- (void)interstitialAdLoaderDidFinishLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidFinishLoadingAd");
}

- (void)interstitialAdLoaderDidFinishLoadingAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidFinishLoadingAdView");
    [self.interstitialAdLoader displayAd];
}

- (void)interstitialAdLoaderDidSkipLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidSkipLoadingAd");
}

- (void)interstitialAdLoaderDidClickIntersititialAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidClickIntersititialAdView:");
}

- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdWithError:(NSError *)error
{
    NSLog(@"interstitialAdLoader:didFailToLoadAdWithError:%@", error);
}

- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdViewWithError:(NSError *)error
{
    NSLog(@"interstitialAdLoader:didFailToLoadAdViewWithError:%@", error);
}

#pragma mark - ADVSIconAdLoaderDelegate

- (void)iconAdLoaderDidStartLoadingAd:(ADVSIconAdLoader *)iconAdLoader
{
    NSLog(@"iconAdLoaderDidStartLoadingAd");
}

- (void)iconAdLoaderDidFinishLoadingAd:(ADVSIconAdLoader *)iconAdLoader
{
    NSLog(@"iconAdLoaderDidFinishLoadingAd");
}

- (void)iconAdLoader:(ADVSIconAdLoader *)iconAdLoader didFailToLoadAdWithError:(NSError *)error
{
    NSLog(@"iconAdLoader:didFailToLoadAdWithError:%@", error);
}

- (void)iconAdLoader:(ADVSIconAdLoader *)iconAdLoader didReceiveIconAdView:(ADVSIconAdView *)iconAdView
{
    NSLog(@"iconAdLoader:didReceiveIconAdView:");
}

- (void)iconAdLoader:(ADVSIconAdLoader *)iconAdLoader didFailToReceiveIconAdView:(ADVSIconAdView *)iconAdView
{
    NSLog(@"iconAdLoader:didFailToReceiveIconAdView:");
}

- (void)iconAdLoader:(ADVSIconAdLoader *)iconAdLoader didClickIconAdView:(ADVSIconAdView *)iconAdView
{
    NSLog(@"iconAdLoader:didClickIconAdView:");
}

#pragma mark - ADVSWallAdLoaderDelegate

- (void)wallAdLoaderWillPresentWallAdView:(ADVSWallAdLoader *)wallAdLoader
{
    NSLog(@"wallAdLoaderWillPresentWallAdView");
}

- (void)wallAdLoaderDidPresentWallAdView:(ADVSWallAdLoader *)wallAdLoader
{
    NSLog(@"wallAdLoaderDidPresentWallAdView");
}

- (void)wallAdLoaderWillDismissWallAdView:(ADVSWallAdLoader *)wallAdLoader
{
    NSLog(@"wallAdLoaderWillDismissWallAdView");
}

- (void)wallAdLoaderDidDismissWallAdView:(ADVSWallAdLoader *)wallAdLoader
{
    NSLog(@"wallAdLoaderDidDismissWallAdView");
}

- (void)wallAdLoader:(ADVSWallAdLoader *)wallAdLoader didFailToLoadAdWithError:(NSError *)error
{
    NSLog(@"wallAdLoader:didFailToLoadAdWithError:%@", error);
}

- (void)wallAdLoaderDidFinishNotifyingApp:(ADVSWallAdLoader *)wallAdLoader
{
    [self.activityIndicator stopAnimating];
    [self showAlertWithMessage:@"Finished App Imp"];
}

- (void)wallAdLoader:(ADVSWallAdLoader *)wallAdLoader didFailToNotifyAppImpWithError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
    [self showAlertWithMessage:[error localizedDescription]];
}

- (void)wallAdLoaderDidGetWallLead:(ADVSWallAdLoader *)wallAdLoader imageURL:(NSURL *)imageURL width:(NSInteger)width height:(NSInteger)height
{
    [self.activityIndicator stopAnimating];
    NSString *message = [NSString stringWithFormat:@"Finished RequestWallLead\nwidth: %d\nheight: %d\nimageURL: %@", (int)width, (int)height, imageURL];
    [self showAlertWithMessage:message];
}

- (void)wallAdLoader:(ADVSWallAdLoader *)wallAdLoader didFailToRequestWallLeadWithError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
    [self showAlertWithMessage:[error localizedDescription]];
}
@end
