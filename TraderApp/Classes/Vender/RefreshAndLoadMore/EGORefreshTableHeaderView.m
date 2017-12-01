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

#import "EGORefreshTableHeaderView.h"
#import "UIColor+Util.h"

@interface EGORefreshTableHeaderView (Private)

- (void)setState:(EGOPullState)aState;
@end

@implementation EGORefreshTableHeaderView {
    UIView *_botView;
    EGOPullState _state;
    
    UILabel *_lastUpdatedLabel;
    UILabel *_statusLabel;
    CALayer *_arrowImage;
    UIActivityIndicatorView *_activityView;
    
    BOOL isLoading;
    
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        isLoading = NO;
        
        _botView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 0)];
        _botView.backgroundColor = [UIColor clearColor];
        _botView.clipsToBounds = YES;
        [self addSubview:_botView];
        
        _lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, - 30, self.frame.size.width, 20.0f)];
        _lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _lastUpdatedLabel.font = [UIFont systemFontOfSize:12.0f];
        _lastUpdatedLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _lastUpdatedLabel.backgroundColor = [UIColor clearColor];
        _lastUpdatedLabel.textAlignment = NSTextAlignmentCenter;
        _lastUpdatedLabel.textColor = DEFAULT_TEXT_COLOR;
        _lastUpdatedLabel.shadowColor = [_lastUpdatedLabel.textColor colorWithAlphaComponent:0.1f];
        _lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [_botView addSubview:_lastUpdatedLabel];
        
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, - 48, self.frame.size.width, 20.0f)];
        _statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        _statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.textColor = DEFAULT_TEXT_COLOR;
        _statusLabel.shadowColor = [_statusLabel.textColor colorWithAlphaComponent:0.1f];
        _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [_botView addSubview:_statusLabel];
        
        /* Config Arrow Image */
        UIView *lView = [[UIView alloc] initWithFrame:CGRectMake(0, -65, 80, 65)];
        lView.backgroundColor = [UIColor clearColor];
        lView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [_botView addSubview:lView];
        
        _arrowImage = [[CALayer alloc] init];
        _arrowImage.frame = CGRectMake(25, 0, 30, 55);
        _arrowImage.contentsGravity = kCAGravityResizeAspect;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            _arrowImage.contentsScale = [[UIScreen mainScreen] scale];
        }
#endif
        _arrowImage.contents = (id)([UIImage imageNamed:@"blueArrow"].CGImage);
        [[lView layer] addSublayer:_arrowImage];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:DEFAULT_ACTIVITY_INDICATOR_STYLE];
        _activityView.frame = CGRectMake(25.0f,- 38, 20.0f, 20.0f);
        _activityView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _activityView.hidesWhenStopped = YES;
        [_botView addSubview:_activityView];
        
        [self setState:EGOOPullNormal];
    }
    return self;
}


#pragma mark -
#pragma mark Setters

#define aMinute 60
#define anHour 3600
#define aDay 86400

- (void)refreshLastUpdatedDate {
    NSDate *lastRefDate = nil;
    if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) {
        lastRefDate = [_delegate egoRefreshTableHeaderDataSourceLastUpdated:self];
    }
    if(lastRefDate) {
        NSTimeInterval timeSinceLastUpdate = [lastRefDate timeIntervalSinceNow];
        NSInteger timeToDisplay = 0;
        timeSinceLastUpdate *= -1;
        
        if(timeSinceLastUpdate < anHour) {
            timeToDisplay = (NSInteger) (timeSinceLastUpdate / aMinute);
            
            if(timeToDisplay < 1) {
                _lastUpdatedLabel.text = [NSString stringWithFormat:@"上次更新时间:刚刚"];
            } else {
                _lastUpdatedLabel.text = [NSString stringWithFormat:@"上次更新时间: %ld 分钟前",(long)timeToDisplay];
            }
            
        } else if (timeSinceLastUpdate < aDay) {
            timeToDisplay = (NSInteger) (timeSinceLastUpdate / anHour);
            _lastUpdatedLabel.text = [NSString stringWithFormat:@"上次更新时间: %ld 小时前",(long)timeToDisplay];
            
        } else {
            timeToDisplay = (NSInteger) (timeSinceLastUpdate / aDay);
            _lastUpdatedLabel.text = [NSString stringWithFormat:@"上次更新时间: %ld 天前",(long)timeToDisplay];
        }
    } else {
        _lastUpdatedLabel.text = nil;
    }
}

- (void)setState:(EGOPullState)aState {
    
    switch (aState) {
        case EGOOPullPulling:
            
            _statusLabel.text = @"松开即可刷新...";
            [CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
            
            break;
        case EGOOPullNormal:
            
            if (_state == EGOOPullPulling) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
                _arrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
            }
            
            _statusLabel.text = @"下拉即可刷新...";
            [_activityView stopAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = NO;
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
            
            [self refreshLastUpdatedDate];
            
            break;
        case EGOOPullLoading:
            
            _statusLabel.text = @"加载中...";
            [_activityView startAnimating];
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
    
    if (_state == EGOOPullLoading) {
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, PULL_AREA_HEIGTH);
        UIEdgeInsets currentInsets = scrollView.contentInset;
        currentInsets.top = offset;
        scrollView.contentInset = currentInsets;
        
    } else if (scrollView.isDragging) {
        if (_state == EGOOPullPulling && scrollView.contentOffset.y > - PULL_TRIGGER_HEIGHT && scrollView.contentOffset.y < 0.0f && !isLoading) {
            [self setState:EGOOPullNormal];
        } else if (_state == EGOOPullNormal && scrollView.contentOffset.y < - PULL_TRIGGER_HEIGHT && !isLoading) {
            [self setState:EGOOPullPulling];
            
        }
        if (scrollView.contentInset.top != 0) {
            UIEdgeInsets currentInsets = scrollView.contentInset;
            currentInsets.top = 0;
            scrollView.contentInset = currentInsets;
        }
    }
    float bot = 0;
    if (scrollView.contentOffset.y < 0) {
        bot = - scrollView.contentOffset.y;
    } else bot = 0;
    _botView.frame = CGRectMake(_botView.frame.origin.x, self.frame.size.height - bot, _botView.frame.size.width, bot);
}

- (void)startAnimatingWithScrollView:(UIScrollView *) scrollView {
    if (!isLoading && [_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)] && !self.hidden) {
        isLoading = YES;
        [self setState:EGOOPullLoading];
        [UIView animateWithDuration:0.2 animations:^{
            scrollView.contentInset = UIEdgeInsetsMake(PULL_AREA_HEIGTH, scrollView.contentInset.left, scrollView.contentInset.bottom, scrollView.contentInset.right);
            [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, - PULL_TRIGGER_HEIGHT) animated:YES];
        }];
        [_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
    }
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= - PULL_TRIGGER_HEIGHT && !isLoading) {
        [self startAnimatingWithScrollView:scrollView];
    }
}
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    isLoading = NO;
    UIEdgeInsets currentInsets = scrollView.contentInset;
    currentInsets.top = 0;
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentInset = currentInsets;
    }];
    [self setState:EGOOPullNormal];
}

- (void)egoRefreshScrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self refreshLastUpdatedDate];
}

#pragma mark - dealloc

- (void)dealloc {
    _delegate = nil;
}

@end
