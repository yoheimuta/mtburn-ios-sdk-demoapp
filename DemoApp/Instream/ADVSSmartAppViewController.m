//
//  ADVSSmartViewController.m
//  DemoApp
//
//  Created by M.T.Burn on 2014/04/17.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//

#import "ADVSSmartAppViewController.h"
#import <AppDavis/ADVSInstreamAdLoader.h>
#import "ADVSSmartAppArticle1x1TableViewCell.h"
#import "ADVSSmartAppArticle1x3TableViewCell.h"
#import "ADVSSmartAppArticle3x1TableViewCell.h"
#import "ADVSSmartAppArticleModel.h"
#import "MNMBottomPullToRefreshManager.h"

@interface ADVSSmartAppViewController () <ADVSInstreamAdLoaderDelegate, MNMBottomPullToRefreshManagerClient,NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) ADVSInstreamAdLoader *instreamAdLoader;
@property(nonatomic, strong) NSMutableArray *items;
@property(nonatomic, strong) ADVSSmartAppArticleModel *item;
@property(nonatomic, strong) NSXMLParser *parser;
@property(nonatomic, strong) NSString *elementName;
@property(nonatomic, strong) MNMBottomPullToRefreshManager* refreshManager;
@end

@implementation ADVSSmartAppViewController

#pragma mark - LifyCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = [[NSMutableArray alloc] init];
	
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ADVSSmartAppArticle1x1TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell1x1"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ADVSSmartAppArticle1x3TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell1x3"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ADVSSmartAppArticle3x1TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell3x1"];
    
    // 上部Viewをpullして、新規にリロード処理を開始する
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(startDownload) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    // 下部Viewをpullして、追加でリロード処理を開始する
    self.refreshManager = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0 tableView:self.tableView withClient:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.refreshManager relocatePullToRefreshView];
}

#pragma mark - Public
- (void)bindToSdk
{
    self.instreamAdLoader = [ADVSInstreamAdLoader new];
    self.instreamAdLoader.delegate = self;
    [self.instreamAdLoader bindToTableView:self.tableView adSpotId:_confDict[@"adSpotId"]];
}

- (void)startDownload
{
    [_items removeAllObjects];
    
    NSURL *url = [NSURL URLWithString:_confDict[@"url"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
         _parser = [[NSXMLParser alloc] initWithData:data];
         _parser.delegate = self;
         [_parser parse];
     }];
}

- (void)loadMore
{
    NSMutableArray *temp = [NSMutableArray arrayWithArray:_items];
    for (int i = 0; i < 40; i++) {
        if (i < [_items count]) {
            [temp addObject:_items[i]];
        }
    }
    _items = temp;
    
    [self.instreamAdLoader loadAd:5 positions:@[@5,@10,@15,@20,@25]];
    
    [self.view layoutIfNeeded];
    [self.refreshManager tableViewReloadFinished];
}

#pragma mark - Private
- (UITapGestureRecognizer *)tapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapped:)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    
    return tap;
}

-(void)tapped:(UITapGestureRecognizer*)sender
{
    int itemIndex = (int)[sender view].tag;
    if (_items.count <= itemIndex) {
        NSAssert(NO, @"Invalid array index range:%d", itemIndex);
        return;
    }
    
    ADVSSmartAppArticleModel *item = _items[itemIndex];
    NSString *link = [item.link stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!link) {
        NSAssert(NO, @"Not Found link in item:%d", itemIndex);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:link];
    if (!url) {
        NSAssert(NO, @"Invalid url because of maybe invalid format string:%@", link);
        return;
    }
    
    if ([_delegate respondsToSelector:@selector(openUIWebView:)]) {
        [_delegate openUIWebView:url];
    }
}

#pragma mark - ADVSInstreamAdLoaderDelegate
- (void)instreamAdLoaderDidStartLoadingAd:(ADVSInstreamAdLoader *)instreamAdLoader
{
    NSLog(@"instreamAdLoaderDidStartLoadingAd");
}

- (void)instreamAdLoaderDidFinishLoadingAd:(ADVSInstreamAdLoader *)instreamAdLoader
{
    NSLog(@"instreamAdLoaderDidFinishLoadingAd");
}

- (void)instreamAdLoaderDidFinishLoadingAdImage:(NSIndexPath *)adIndexPath
{
    NSLog(@"instreamAdLoaderDidFinishLoadingAdImage:row=%d:section=%d", (int)adIndexPath.row, (int)adIndexPath.section);
}

- (void)instreamAdLoaderDidFinishSendingAdClick
{
    NSLog(@"instreamAdLoaderDidClickInstreamAd");
}

- (void)instreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToLoadAdWithError:(NSError *)error
{
    NSLog(@"instreamAdLoader:didFailToLoadAdWithError:%@", error);
}

- (void)instreamAdLoader:(NSIndexPath *)adIndexPath didFailToLoadAdImageWithError:(NSError *)error
{
    NSLog(@"instreamAdLoaderDidFailToLoadAdImage:row=%d:section=%d:error=%@", (int)adIndexPath.row, (int)adIndexPath.section, error);
}

# pragma mark - MNMBottomPullToRefreshManager
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.refreshManager tableViewScrolled];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.refreshManager tableViewReleased];
}

- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager
{
    [self performSelector:@selector(loadMore) withObject:nil afterDelay:0.3f];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    _elementName = elementName;
    if ([_elementName isEqualToString:@"item"]) {
        _item             = [[ADVSSmartAppArticleModel alloc] init];
        _item.title       = @"";
        _item.content     = @"";
        _item.link        = @"";
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([_elementName isEqualToString:@"title"]) {
        _item.title       = [_item.title stringByAppendingString:string];
    } else if ([_elementName isEqualToString:@"description"]){
        _item.content     = [_item.content stringByAppendingString:string];
    } else if ([_elementName isEqualToString:@"link"]){
        _item.link        = [_item.link stringByAppendingString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"]) {
        [_items addObject:_item];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
        [self.instreamAdLoader loadAd:5 positions:@[@5,@10,@15,@20,@25]];
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_items.count/4 < 3) {
        return 3;
    }
    return _items.count/3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int numberOfArticles = (int)(indexPath.row / 4) * 12;
    
    ADVSSmartAppArticleModel *item;
    
    // 1x3 or 3x1
    if ((indexPath.row%2) == 0) {
        NSString *CellIdentifier;
        // if you want to customize to display images, delete these commentouts and put image files named [tabname]_[1-4].xxx
        //  tab: see Instream/ADVSSmartAppRssModelManager labels
        //  rotate: range [1-4]
        //  http://gyazo.com/69c251d22e1ddea32cbff8e9f728752f
        //UIImage  *feedImage;
        if ((indexPath.row%4)==0) {
            CellIdentifier = @"Cell1x3";
            //feedImage = [UIImage imageNamed:[_confDict[@"label"] stringByAppendingString:@"3.jpg"]];
        }
        else {
            CellIdentifier = @"Cell3x1";
            numberOfArticles += 6;
            //feedImage = [UIImage imageNamed:[_confDict[@"label"] stringByAppendingString:@"4.jpg"]];
        }
        
        NSLog(@"%@:numberOfArticles=%d, indexPath.row=%d", CellIdentifier,numberOfArticles, (int)indexPath.row);
        
        ADVSSmartAppArticle1x3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (numberOfArticles+3 < _items.count) {
            item = _items[numberOfArticles];
            cell.leftFeed.text = item.title;
            cell.leftView.tag  = numberOfArticles;
            item = _items[++numberOfArticles];
            cell.rightTopFeed.text = item.title;
            cell.rightTopView.tag  = numberOfArticles;
            item = _items[++numberOfArticles];
            cell.rightMiddleFeed.text = item.title;
            cell.rightMiddleView.tag  = numberOfArticles;
            item = _items[++numberOfArticles];
            cell.rightBottomFeed.text = item.title;
            cell.rightBottomView.tag  = numberOfArticles;
            
            //[cell.feedImageView setImage:feedImage];
            
            [cell.leftView  addGestureRecognizer:[self tapGesture]];
            [cell.rightTopView addGestureRecognizer:[self tapGesture]];
            [cell.rightMiddleView addGestureRecognizer:[self tapGesture]];
            [cell.rightBottomView addGestureRecognizer:[self tapGesture]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    // 1x1
    else {
        if ((indexPath.row-1)==0 || (indexPath.row-1)%4 == 0) {
            numberOfArticles += 4;
        } else {
            numberOfArticles += 10;
        }
        
        NSLog(@"Cell1x1:numberOfArticles=%d, indexPath.row=%d", numberOfArticles, (int)indexPath.row);
        
        ADVSSmartAppArticle1x1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1x1"];
        if (numberOfArticles+1 < _items.count) {
            item = _items[numberOfArticles];
            cell.leftFeed.text = item.title;
            cell.leftView.tag = numberOfArticles;
            item = _items[++numberOfArticles];
            cell.rightFeed.text = item.title;
            cell.rightView.tag = numberOfArticles;
            
            //[cell.leftImage setImage:[UIImage imageNamed:[_confDict[@"label"] stringByAppendingString:@"1.jpg"]]];
            //[cell.rightImage setImage:[UIImage imageNamed:[_confDict[@"label"] stringByAppendingString:@"2.jpg"]]];
            
            [cell.leftView  addGestureRecognizer:[self tapGesture]];
            [cell.rightView addGestureRecognizer:[self tapGesture]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1x3 or 3x1
    if ((indexPath.row%2) == 0) {
        return 240;
    }
    // 1x1
    else {
        return 237;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UINib *nib = [UINib nibWithNibName:@"ADVSSmartAppTableViewHeader" bundle:nil];
    UIView *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end