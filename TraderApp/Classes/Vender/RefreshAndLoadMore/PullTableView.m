//
//  PullTableView.m
//  Sideslip
//
//  Created by 834266718 on 15/9/14.
//  Copyright (c) 2015年 834266718. All rights reserved.
//

#import "PullTableView.h"
#import "AppConfig.h"
@interface PullTableView () <EGORefreshTableHeaderDelegate, LoadMoreTableFooterDelegate>

@end
@implementation PullTableView {
    MessageInterceptor *_delegateInterceptor;
}
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _delegateInterceptor = [[MessageInterceptor alloc] init];
        _delegateInterceptor.middleMan = self;
        _delegateInterceptor.receiver = self.delegate;
        super.delegate = (id)_delegateInterceptor;
        
        _pullTableIsRefreshing = NO;
        _pullTableIsLoadingMore = NO;
        
        _refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, - self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
        _refreshView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _refreshView.delegate = self;
        [self addSubview:_refreshView];
        
        _loadMoreView = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
        _loadMoreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _loadMoreView.delegate = self;
        [self addSubview:_loadMoreView];
        self.loadMoreView.alpha = 0;
        
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        self.tableFooterView = footer;
    }
    
    return self;
}
- (void)setTableHeaderView:(UIView *)tableHeaderView {
    [super setTableHeaderView:tableHeaderView];
    if (tableHeaderView.tag == 0) {
        _refreshView.frame = CGRectMake(0, - self.bounds.size.height + tableHeaderView.frame.size.height, self.bounds.size.width, self.bounds.size.height);
    }
}
# pragma mark - View changes

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat visibleTableDiffBoundsHeight = (self.bounds.size.height - MIN(self.bounds.size.height, self.contentSize.height));
    
    CGRect loadMoreFrame = _loadMoreView.frame;
    loadMoreFrame.origin.y = self.contentSize.height + visibleTableDiffBoundsHeight + self.offSet_y;
    _loadMoreView.frame = loadMoreFrame;
}

#pragma mark - Preserving the original behaviour

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    if(_delegateInterceptor) {
        super.delegate = nil;
        _delegateInterceptor.receiver = delegate;
        super.delegate = (id)_delegateInterceptor;
    } else {
        super.delegate = delegate;
    }
}

- (void)reloadData {
    [super reloadData];
    [_loadMoreView egoRefreshScrollViewDidScroll:self];
}

#pragma mark - Status Propreties

- (void)setPullTableIsRefreshing:(BOOL)isRefreshing {
    if(!_pullTableIsRefreshing && isRefreshing) {
        
        [_loadMoreView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        _pullTableIsLoadingMore = NO;
        _loadMoreView.hidden = YES;
        
        [_refreshView startAnimatingWithScrollView:self];
        _pullTableIsRefreshing = YES;
    } else if(!isRefreshing) {
        [_refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        _pullTableIsRefreshing = NO;
        _loadMoreView.hidden = NO;
        _loadMoreView.canStartLoad = YES;
    }
}
- (void)doneLoadingFinish {
    [_refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    _pullTableIsRefreshing = NO;
    
    [_loadMoreView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    _pullTableIsLoadingMore = NO;
    _loadMoreView.hidden = NO;
}
- (void)setPullTableIsLoadingMore:(BOOL)isLoadingMore {
    if (_pullTableIsRefreshing) {
        return;
    }
    if(!_pullTableIsLoadingMore && isLoadingMore) {
        [_loadMoreView startAnimatingWithScrollView:self];
        _pullTableIsLoadingMore = YES;
    } else if(!isLoadingMore) {
        _loadMoreView.hidden = YES;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(doneLoadMoreFinish) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}
- (void)doneLoadMoreFinish {
    [_loadMoreView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    _pullTableIsLoadingMore = NO;
    _loadMoreView.hidden = NO;
}
- (void)setHasLoadAll:(BOOL)hasLoadAll {
    _hasLoadAll = hasLoadAll;
    _loadMoreView.hasLoadAll = hasLoadAll;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_delegateInterceptor.receiver
         respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_delegateInterceptor.receiver scrollViewDidScroll:scrollView];
    }
    if (!_pullTableIsRefreshing) {
        [_refreshView egoRefreshScrollViewDidScroll:scrollView];
        if (!_pullTableIsRefreshing) {
            [_loadMoreView egoRefreshScrollViewDidScroll:scrollView];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([_delegateInterceptor.receiver respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_delegateInterceptor.receiver scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
    if (self.pullTableIsRefreshing) {
        return;
    }
    [_refreshView egoRefreshScrollViewDidEndDragging:scrollView];
    if (!self.pullTableIsLoadingMore) {
        [_loadMoreView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([_delegateInterceptor.receiver
         respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_delegateInterceptor.receiver scrollViewWillBeginDragging:scrollView];
    }
    if (!self.pullTableIsRefreshing) {
        [_refreshView egoRefreshScrollViewWillBeginDragging:scrollView];
    }
}

#pragma mark - EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    
    [_loadMoreView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    _pullTableIsLoadingMore = NO;
    _loadMoreView.hidden = YES;
    
    _pullTableIsRefreshing = YES;
    [_pullDelegate pullTableViewDidTriggerRefresh:self];
    if ([_pullDelegate respondsToSelector:@selector(refreshTableHeaderDataSourceLastUpdated:)]) {
        self.pullLastRefreshDate = [_pullDelegate refreshTableHeaderDataSourceLastUpdated:_refreshView];
    } else {
        self.pullLastRefreshDate = [NSDate date];
    }
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    return self.pullLastRefreshDate;
}

#pragma mark - LoadMoreTableViewDelegate

- (void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTableFooterView *)view {
    if (self.hasLoadAll) {
        [_loadMoreView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        _pullTableIsLoadingMore = NO;
        return;
    }
    
    _pullTableIsLoadingMore = YES;
    [_pullDelegate pullTableViewDidTriggerLoadMore:self];
}

- (void)dealloc {
    _pullDelegate = nil;
}
@end
