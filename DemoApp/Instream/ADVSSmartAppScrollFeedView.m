//
//  ADVSSmartAppScrollFeedView.m
//  DemoApp
//
//  Created by M.T.Burn on 2014/04/18.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//
#import "ADVSSmartAppScrollFeedView.h"

@interface ADVSSmartAppScrollFeedView ()
<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) UIPageViewControllerTransitionStyle transitionStyle;

// for menu
@property (nonatomic) UIScrollView *menuScrollView;
@property (nonatomic) CGSize menuSize;

// for feed
@property (nonatomic) NSArray *viewControllers;
@property (nonatomic) UIPageViewController *pageViewController;

@end


@implementation ADVSSmartAppScrollFeedView

- (id)init
{
    return [self initWithFrame:[UIScreen mainScreen].applicationFrame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithStyle:(UIPageViewControllerTransitionStyle)transitionStyle
{
    self = [self init];
    _transitionStyle = transitionStyle;
    
    if (self) {
        [self initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
              style:(UIPageViewControllerTransitionStyle)transitionStyle
{
    self = [self initWithFrame:frame];
    _transitionStyle = transitionStyle;
    
    if (self) {
        [self initialize];
    }
    return self;
}


- (void)initialize
{
    self.menuScrollView = [[UIScrollView alloc] init];
    _menuScrollView.showsHorizontalScrollIndicator = NO;
    _menuScrollView.backgroundColor = [UIColor blackColor];
    [self addSubview:_menuScrollView];
    
    self.pageViewController = [[UIPageViewController alloc]
                               initWithTransitionStyle:_transitionStyle
                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                               options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;

    [self insertSubview:_pageViewController.view belowSubview:_menuScrollView];
}

- (void)setScrollFeedViewDataSource:(id<ADVSSmartAppScrollFeedViewDataSource>)dataSource {
    _scrollFeedViewDataSource = dataSource;
    [self reloadData];
}

- (void)reloadData {
    _menuSize = [_scrollFeedViewDataSource sizeOfMenuView:self];
    _menuScrollView.frame = CGRectMake(self.frame.origin.x,
                                       self.frame.origin.y,
                                       self.frame.size.width,
                                       _menuSize.height);
    [self layoutMenuScrollView];
    
    _pageViewController.view.frame = CGRectMake(self.frame.origin.x,
                                                self.frame.origin.y+_menuSize.height + 5.0f,
                                                self.frame.size.width,
                                                self.frame.size.height - _menuSize.height);
    
    self.viewControllers = [_scrollFeedViewDataSource viewsForFeedView:self];
    if ([_viewControllers count] > 0) {
        [_pageViewController setViewControllers:@[_viewControllers[0]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    }
}

- (void)layoutMenuScrollView {
    NSArray *menuViews = [_scrollFeedViewDataSource viewsForMenuView:self];
    
    NSInteger index = 0;
    
    for (UIView *v in menuViews) {
        v.frame = CGRectMake(_menuSize.width * index, 0, _menuSize.width, _menuSize.height);
        v.tag = index;
        v.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(didTapMenuView:)];
        [v addGestureRecognizer:tapGesture];
        
        [_menuScrollView addSubview:v];
        index++;
    }
    _menuScrollView.contentSize = CGSizeMake(_menuSize.width * index, _menuSize.height);
}

- (UIPageViewControllerTransitionStyle)transitionStyle {
    return _pageViewController.transitionStyle;
}

- (UIPageViewControllerNavigationOrientation)navigationOrientation {
    return _pageViewController.navigationOrientation;
}


#pragma mark - UIPageViewControlDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger page = [self indexOfViewController:viewController];

    if (page == NSNotFound) {
        return nil;
    }
    if (page == 0) {
        return nil;
    }
    
    page--;
    
    return _viewControllers[page];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger page = [self indexOfViewController:viewController];
    
    if (page == NSNotFound) {
        return nil;
    }
    if (page == [_scrollFeedViewDataSource numberOfPages:self] - 1) {
        return nil;
    }
    page++;
    
    return _viewControllers[page];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    if ([pendingViewControllers count] > 0) {
        NSInteger page = [self indexOfViewController:pendingViewControllers[0]];
        _currentPageIndex = page;
        
        [self moveToPageIndexInMenuScrollViewWithIndex:_currentPageIndex];
    }
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    return [_viewControllers indexOfObject:viewController];
}


#pragma mark - MenuScrollView Methods

- (void)moveToPageIndexInMenuScrollViewWithIndex:(NSInteger)index {
    CGRect destFrame = CGRectMake(index * _menuSize.width + _menuSize.width/2 - 160,
                                  0,
                                  _menuScrollView.frame.size.width,
                                  _menuScrollView.frame.size.height);
    [_menuScrollView scrollRectToVisible:destFrame animated:YES];
}

- (void)didTapMenuView:(UITapGestureRecognizer *)gesture {
    UIView *view = [gesture view];
    NSInteger destIndex = view.tag;
    
    if (_currentPageIndex == destIndex) {
        return;
    }
    
    UIPageViewControllerNavigationDirection direction;
    if (_currentPageIndex > destIndex) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    } else {
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    
    __unsafe_unretained id _self = self;
    
    [_pageViewController setViewControllers:@[_viewControllers[destIndex]]
                                  direction:direction
                                   animated:YES
                                 completion:^(BOOL finished) {
                                     [_self didChangeCurrentPage];
                                 }];
    _currentPageIndex = destIndex;
    
    [self moveToPageIndexInMenuScrollViewWithIndex:destIndex];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    [self didChangeCurrentPage];
}

- (void)didChangeCurrentPage {
    if ([_scrollFeedViewDelegate respondsToSelector:@selector(scrollFeedView:didChangeCurrentPage:)]) {
        [_scrollFeedViewDelegate scrollFeedView:self didChangeCurrentPage:_currentPageIndex];
    }
}

@end
