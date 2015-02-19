//
//  ADVSInstreamAdLoader.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/04/17.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADVSInstreamAdLoaderDelegate.h"

@protocol ADVSInstreamInfoProtocol;

/**
 `ADVSInstreamAdLoader` is for loading instream type advertisements.
 if you want to do so,
 
 2 ways to be prepared by our sdk to load advertisements.
 
 1) full control by sdk
  1. instantiate this class.
  2. call - bindToTableView
  3. call - loadAd or loadAd:adCount:positions
  4. call when your tableview is reloaded - reloadData
 
 2) some control by sdk
  1. instantiate this class.
  2. call - loadAdWithReturn:adCount:positions
  3. call when an advertisement is displayed - measureImp
  4. call when an advertisement is clicked   - sendClickEvent
 
 That's it!
 */

@interface ADVSInstreamAdLoader : NSObject
/**
 This delegate tells loading instream advertisement results.
 
 @see ADVSInstreamAdLoaderDelegate.h
 */
@property(nonatomic, weak) id<ADVSInstreamAdLoaderDelegate> delegate;

/**
 binds this loader to your table view.
 
 @param tableView tableView to be binded by this loader
 @param adSpotId  adSpotId to be registered in advance
 
 */

- (void)bindToTableView:(UITableView *)tableView adSpotId:(NSString *)adSpotId;

/**
 starts loading advertisements for inserting cells to binded tableview and then reload your tableview
 Use it if you want to use parameters registered at the management webpage in advance.
 */

- (void)loadAd;

/**
 starts loading advertisements for inserting limited cells to binded tableview and then reload your tableview,
 if you want to do so.
 
 @param adCount   advertisement cell count to be put in tableView. If 0 is given, registered is selected.
 @param positions each advertisement cell are put at the position in tableView. If nil is given, registered is selected.
 */

- (void)loadAd:(NSUInteger)adCount positions:(NSArray*)positions;

/**
 starts loading advertisements for receiving advertisement informations,
 if you want to do so.
 
 @param adSpotId  adSpotId to be registered in advance
 @param adCount   advertisement information count to be received in the callback. If 0 is given, registered is selected.
 @param positions each position to be added into `ADVSInstreamInfoModel` in order to control ad position. If nil is given, registered is selected.
 
 ex. [self.instreamAdLoader loadAdWithReturn:6 adCount:5 positions:@[@3,@6,@9,@12,@15]];
 */

- (void)loadAdWithReturn:(NSString *)adSpotId adCount:(NSUInteger)adCount positions:(NSArray*)positions;

/**
 send an impression record to log advertising performance.

 @param instreamInfoModel advertisement information model to be received in loadAd:adCount:positions
 */

- (void)measureImp:(id<ADVSInstreamInfoProtocol>)instreamInfoProtocol;

/**
 send an click record to log advertising performance.
 
 @param instreamInfoModel advertisement information model to be received in loadAd:adCount:positions
 */

- (void)sendClickEvent:(id<ADVSInstreamInfoProtocol>)instreamInfoProtocol;

/**
 reload data in your binded tableview.
 if you used `bindToTableView:adSpotId:`, invoke this method instead of [your_table_view reloadData].
 
 loadAd and loadAd:adCount:positions methods invoke this method internally, so you don't have to invoke 
 this method explicitly in normal use case.
 
 */
- (void)reloadData;

/**
 sets an adSpotId.
 if you change an adSpotId dynamically, you can use it.
 
 @param adSpotId  adSpotId to be registered in advance
 
 */
- (void)setAdSpotId:(NSString *)adSpotId;
@end
