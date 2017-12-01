//
//  PullTableView.h
//  Sideslip
//
//  Created by 834266718 on 15/9/14.
//  Copyright (c) 2015年 834266718. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageInterceptor.h"
#import "EGORefreshTableHeaderView.h"
#import "LoadMoreTableFooterView.h"
@interface PullTableView : UITableView
@property (nonatomic, retain) EGORefreshTableHeaderView *refreshView;
@property (nonatomic, retain) LoadMoreTableFooterView *loadMoreView;
@property (nonatomic, assign) float offSet_y;
@property (nonatomic, assign) BOOL hasLoadAll;

@property (nonatomic, retain) NSDate *pullLastRefreshDate;

@property (nonatomic, assign) BOOL pullTableIsRefreshing;
@property (nonatomic, assign) BOOL pullTableIsLoadingMore;

@property (nonatomic, assign) id pullDelegate;
@end
@protocol PullTableViewDelegate <NSObject>

/* After one of the delegate methods is invoked a loading animation is started, to end it use the respective status update property */
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView;
- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView;
@optional
- (NSDate*)refreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view;

@end