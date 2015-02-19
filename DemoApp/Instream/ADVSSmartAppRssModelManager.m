//
//  ADVSSmartAppRssModelManager.m
//  DemoApp
//
//  Created by M.T.Burn on 2014/04/21.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//

#import "ADVSSmartAppRssModelManager.h"
#import <AppDavis/ADVSInstreamAdLoader.h>
#import "ADVSAppDelegate.h"

@implementation ADVSSmartAppRssModelManager
+(NSDictionary *) rssDictModel:(NSNumber *)index
{
    ADVSAppDelegate *delegate = (ADVSAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSArray *adSpotIdWithVisualIdDictForInstream = [delegate adspotIdDict][@"instream"];
    
    NSArray *modelArray = @[
      @{@"label": @"トップ", @"url": @"http://rss.asahi.com/rss/asahi/newsheadlines.rdf", @"adSpotId": adSpotIdWithVisualIdDictForInstream[0],
        @"color": [UIColor colorWithRed:255/255.0 green:7/255.0 blue:0/255.0 alpha:1.0]},
      @{@"label": @"エンタメ", @"url": @"http://www3.asahi.com/rss/culture.rdf", @"adSpotId": adSpotIdWithVisualIdDictForInstream[1],
        @"color": [UIColor colorWithRed:0/255.0 green:147/255.0 blue:255/255.0 alpha:1.0]},
      @{@"label": @"スポーツ", @"url": @"http://www3.asahi.com/rss/sports.rdf", @"adSpotId": adSpotIdWithVisualIdDictForInstream[2],
        @"color": [UIColor colorWithRed:0/255.0 green:201/255.0 blue:13/255.0 alpha:1.0]},
      @{@"label": @"グルメ", @"url": @"http://www3.asahi.com/rss/book.rdf", @"adSpotId": adSpotIdWithVisualIdDictForInstream[3],
        @"color": [UIColor colorWithRed:255/255.0 green:118/255.0 blue:0/255.0 alpha:1.0]},
      @{@"label": @"国内", @"url": @"http://www3.asahi.com/rss/national.rdf", @"adSpotId": adSpotIdWithVisualIdDictForInstream[4],
        @"color": [UIColor colorWithRed:155/255.0 green:39/255.0 blue:102/255.0 alpha:1.0]},
      @{@"label": @"国際", @"url": @"http://www3.asahi.com/rss/politics.rdf", @"adSpotId": adSpotIdWithVisualIdDictForInstream[5],
        @"color": [UIColor colorWithRed:255/255.0 green:7/255.0 blue:0/255.0 alpha:1.0]},
      @{@"label": @"経済", @"url": @"http://www3.asahi.com/rss/business.rdf", @"adSpotId": adSpotIdWithVisualIdDictForInstream[6],
        @"color": [UIColor colorWithRed:0/255.0 green:147/255.0 blue:255/255.0 alpha:1.0]},
      @{@"label": @"テクノロジー", @"url": @"http://rss.rssad.jp/rss/itmatmarkit/rss.xml", @"adSpotId": adSpotIdWithVisualIdDictForInstream[7],
        @"color": [UIColor colorWithRed:0/255.0 green:201/255.0 blue:13/255.0 alpha:1.0]},
      @{@"label": @"政治", @"url": @"http://www3.asahi.com/rss/international.rdf",@"adSpotId": adSpotIdWithVisualIdDictForInstream[8],
       @"color": [UIColor colorWithRed:255/255.0 green:118/255.0 blue:0/255.0 alpha:1.0]},
      ];
    return modelArray[[index intValue]];
}
@end