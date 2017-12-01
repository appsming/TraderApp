//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "LoadMoreTableFooterView.h"


@interface LoadMoreTableFooterView (Private)
- (void)setState:(EGOPullState)aState;
- (CGFloat)scrollViewOffsetFromBottom:(UIScrollView *) scrollView;
- (CGFloat)visibleTableHeightDiffWithBoundsHeight:(UIScrollView *) scrollView;
@end

@implementation LoadMoreTableFooterView {
    EGOPullState _state;
    
    UILabel *_statusLabel;
    CALayer *_arrowImage;
    UIActivityIndicatorView *_activityView;
    UILabel *_nothingLabel;
    BOOL isLoading;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        isLoading = NO;
        self.alpha = 0;
        CGFloat midY = PULL_AREA_HEIGTH / 2;
        
        /* Config Status Updated Label */
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, midY - 10, self.frame.size.width, 20.0f)];
        _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        _statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.textColor = DEFAULT_TEXT_COLOR;
        _statusLabel.shadowColor = [_statusLabel.textColor colorWithAlphaComponent:0.1f];
        [self addSubview:_statusLabel];
        
        _nothingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 15, self.frame.size.width, 20.0f)];
        _nothingLabel.text = @"没有更多信息了";
        _nothingLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _nothingLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        _nothingLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _nothingLabel.backgroundColor = [UIColor clearColor];
        _nothingLabel.textAlignment = NSTextAlignmentCenter;
        _nothingLabel.textColor = DEFAULT_TEXT_COLOR;
        _nothingLabel.alpha = 0.5;
        _nothingLabel.shadowColor = [_statusLabel.textColor colorWithAlphaComponent:0.1f];
        [self addSubview:_nothingLabel];
        
        _arrowImage = [[CALayer alloc] init];
        _arrowImage.frame = CGRectMake(25.0f,midY - 20, 30.0f, 55.0f);
        _arrowImage.contentsGravity = kCAGravityResizeAspect;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            _arrowImage.contentsScale = [[UIScreen mainScreen] scale];
        }
#endif
        _arrowImage.contents = (id)([UIImage imageNamed:@"blueArrow"].CGImage);
        [[self layer] addSublayer:_arrowImage];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:DEFAULT_ACTIVITY_INDICATOR_STYLE];
        _activityView.frame = CGRectMake(25.0f,midY - 8, 20.0f, 20.0f);
        [self addSubview:_activityView];
        
        [self setState:EGOOPullNormal];
        
        self.hasLoadAll = NO;
    }
    return self;
}

#pragma mark - Util
- (CGFloat)scrollViewOffsetFromBottom:(UIScrollView *) scrollView {
    CGFloat scrollAreaContenHeight = scrollView.contentSize.height;
    CGFloat visibleTableHeight = MIN(scrollView.bounds.size.height, scrollAreaContenHeight);
    CGFloat scrolledDistance = scrollView.contentOffset.y + visibleTableHeight; // If scrolled all the way down this should add upp to the content heigh.
    CGFloat normalizedOffset = scrollAreaContenHeight -scrolledDistance;
    return normalizedOffset;
}

- (CGFloat)visibleTableHeightDiffWithBoundsHeight:(UIScrollView *) scrollView {
    return (scrollView.bounds.size.height - MIN(scrollView.bounds.size.height, scrollView.contentSize.height));
}

- (void)setCanStartLoad:(BOOL)canStartLoad {
    if (canStartLoad) {
        self.alpha = 1;
    } else {
        self.alpha = 0;
    }
    _canStartLoad = canStartLoad;
}
#pragma mark -
#pragma mark Setters


- (void)setState:(EGOPullState)aState{
    
    switch (aState) {
        case EGOOPullPulling:
            
            _statusLabel.text = @"松开即可加载更多...";
            [CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
            
            break;
        case EGOOPullNormal:
            
            if (_state == EGOOPullPulling) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
                _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
                [CATransaction commit];
            }
            
            _statusLabel.text = @"上提即可加载更多...";
            [_activityView stopAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            if (!self.hasLoadAll) {
                _arrowImage.hidden = NO;
            }
            _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
            
            break;
        case EGOOPullLoading:
            
            _statusLabel.text = @"加载中...";
            if (!self.hasLoadAll) {
                [_activityView startAnimating];
            }
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = YES;
            [CATransaction commit];
            
            break;
        default:
            break;
    }
    _state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods


- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_canStartLoad) {
        return;
    }
    CGFloat bottomOffset = [self scrollViewOffsetFromBottom:scrollView];
    if (_state == EGOOPullLoading) {
        
        CGFloat offset = MAX(bottomOffset * -1, 0);
        offset = MIN(offset, PULL_AREA_HEIGTH);
        UIEdgeInsets currentInsets = scrollView.contentInset;
        currentInsets.bottom = offset? offset + [self visibleTableHeightDiffWithBoundsHeight:scrollView]: 0;
        scrollView.contentInset = currentInsets;
        
    } else if (scrollView.isDragging) {
        if (_state == EGOOPullPulling && bottomOffset > -PULL_TRIGGER_HEIGHT && bottomOffset < 0.0f && !isLoading) {
            [self setState:EGOOPullNormal];
        } else if (_state == EGOOPullNormal && bottomOffset < -PULL_TRIGGER_HEIGHT && !isLoading) {
            [self setState:EGOOPullPulling];
        }
        
        if (scrollView.contentInset.bottom != 0) {
            UIEdgeInsets currentInsets = scrollView.contentInset;
            currentInsets.bottom = 0;
            scrollView.contentInset = currentInsets;
        }
    }
}

- (void)startAnimatingWithScrollView:(UIScrollView *) scrollView {
    if (!isLoading && [_delegate respondsToSelector:@selector(loadMoreTableFooterDidTriggerLoadMore:)]) {
        isLoading = YES;
        [self setState:EGOOPullLoading];
        UIEdgeInsets currentInsets = scrollView.contentInset;
        currentInsets.bottom = PULL_AREA_HEIGTH + [self visibleTableHeightDiffWithBoundsHeight:scrollView];
        [UIView animateWithDuration:0.2 animations:^{
            scrollView.contentInset = currentInsets;
        }];
        if([self scrollViewOffsetFromBottom:scrollView] == 0){
            [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + PULL_TRIGGER_HEIGHT) animated:YES];
        }
        [_delegate loadMoreTableFooterDidTriggerLoadMore:self];
    }
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    if (!_canStartLoad) {
        return;
    }
    if ([self scrollViewOffsetFromBottom:scrollView] <= - PULL_TRIGGER_HEIGHT && !isLoading && !self.hasLoadAll) {
        if ([_delegate respondsToSelector:@selector(loadMoreTableFooterDidTriggerLoadMore:)]) {
            [self startAnimatingWithScrollView:scrollView];
        }
    }
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    if (!_canStartLoad) {
        return;
    }
    isLoading = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentInset = UIEdgeInsetsMake(scrollView.contentInset.top, scrollView.contentInset.left, 0, scrollView.contentInset.right);
    }];
    
    [self setState:EGOOPullNormal];
    
}
- (void)setHasLoadAll:(BOOL)hasLoadAll {
    _hasLoadAll = hasLoadAll;
    if (hasLoadAll) {
        _statusLabel.hidden = YES;
        _arrowImage.hidden = YES;
        _activityView.alpha = 0;
        _nothingLabel.hidden = NO;
    } else {
        _statusLabel.hidden = NO;
        _arrowImage.hidden = NO;
        _activityView.alpha = 1;
        _nothingLabel.hidden = YES;
    }
}

#pragma mark - Dealloc

- (void)dealloc {
    _delegate = nil;
}


@end
