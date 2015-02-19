//
//  ADVSSmartAppScrollFeedView.h
//  DemoApp
//
//  Created by M.T.Burn on 2014/04/18.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ADVSSmartAppScrollFeedView;

@protocol ADVSSmartAppScrollFeedViewDataSource <NSObject>
@required
- (NSInteger)numberOfPages:(ADVSSmartAppScrollFeedView *)scrollFeedView;
- (CGSize)sizeOfMenuView:(ADVSSmartAppScrollFeedView *)scrollFeedView;
- (NSArray *)viewsForMenuView:(ADVSSmartAppScrollFeedView *)scrollFeedView;
- (NSArray *)viewsForFeedView:(ADVSSmartAppScrollFeedView *)scrollFeedView;

@end

@protocol ADVSSmartAppScrollFeedViewDelegate <NSObject>

- (void)scrollFeedView:(ADVSSmartAppScrollFeedView *)scrollFeedView didChangeCurrentPage:(NSInteger)page;

@end


@interface ADVSSmartAppScrollFeedView : UIView

@property (nonatomic, assign) id<ADVSSmartAppScrollFeedViewDataSource> scrollFeedViewDataSource;
@property (nonatomic, assign) id<ADVSSmartAppScrollFeedViewDelegate> scrollFeedViewDelegate;

@property (nonatomic, readonly) NSInteger currentPageIndex;
@property (nonatomic, readonly) UIPageViewControllerTransitionStyle transitionStyle;

- (id)initWithStyle:(UIPageViewControllerTransitionStyle)transitionStyle;
- (id)initWithFrame:(CGRect)frame
              style:(UIPageViewControllerTransitionStyle)transitionStyle;

- (void)reloadData;

@end
