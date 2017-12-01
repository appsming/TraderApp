//
//  NewsViewController.m
//  TraderApp
//
//  Created by tao song on 17/4/22.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDetailViewController.h"

#import "PullTableView.h"
#import "BaseResponse.h"
#import "NewsInfo.h"

@interface NewsViewController ()  <UITableViewDataSource, UITableViewDelegate, PullTableViewDelegate>

@end

@implementation NewsViewController
{
    UIView         *_moveView;
    NSMutableArray *_btnArr;
    
    NSMutableArray *_totalArray;
    NSMutableArray *_tableArray;
    NSMutableArray *_nothingArray;
    
    UIScrollView   *_scrollView;
     bool            _request[4];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.clipsToBounds = YES;
    
    UIView *segView = [[UIView alloc] initWithFrame:CGRectMake(0, NaviHeight, ScreenWidth, 42)];
    segView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:segView];
    
    _btnArr = [[NSMutableArray alloc] init];
    NSArray *titleArr = [NSArray arrayWithObjects:@"头条新闻",@"编辑推荐", @"市场快讯", @"原油市场", nil];
    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *btn = [self creatMyBtn:CGRectMake(ScreenWidth / titleArr.count * i, 0, ScreenWidth / titleArr.count, 42) aview:segView tag:i];
        [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        if (i == 0) {
            [btn setTitleColor:[UIColor colorFromHexRGB:XIAN_BLUE] forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:[UIColor colorFromHexRGB:@"000000"] forState:UIControlStateNormal];
        }
        [segView addSubview:btn];
        [_btnArr addObject:btn];
        if (i > 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 12, LINE_HEIGHT, segView.frame.size.height - 24)];
            line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
            [btn addSubview:line];
        }
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 41.5, ScreenWidth, LINE_HEIGHT)];
    line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [segView addSubview:line];
    
    _moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth / titleArr.count, 2)];
    _moveView.backgroundColor = [UIColor colorFromHexRGB:XIAN_BLUE];
    [segView addSubview:_moveView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, segView.frame.origin.y + segView.frame.size.height, ScreenWidth, ScreenHeight - segView.frame.origin.y - segView.frame.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(ScreenWidth * titleArr.count, _scrollView.frame.size.height);
    NSMutableArray *daijieArr = [[NSMutableArray alloc] init];
    NSMutableArray *daiquArr = [[NSMutableArray alloc] init];
    NSMutableArray *peisongArr = [[NSMutableArray alloc] init];
    NSMutableArray *wanchengArr = [[NSMutableArray alloc] init];
    _totalArray = [NSMutableArray arrayWithObjects:daijieArr, daiquArr, peisongArr, wanchengArr, nil];
    _tableArray = [[NSMutableArray alloc] init];
    _nothingArray = [[NSMutableArray alloc] init];

    NSArray *nothingsArray = [NSArray arrayWithObjects:@"没有搜索到记录数据", @"没有搜索到记录数据", @"没有搜索到记录数据",@"没有搜索到记录数据", nil];
    
    for (int i = 0; i < nothingsArray.count; i ++) {
        PullTableView *tableView = [[PullTableView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, _scrollView.frame.size.height) style:UITableViewStylePlain];
        tableView.tag = i;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.pullDelegate = self;
        [_scrollView addSubview:tableView];
        tableView.hasLoadAll = YES;
        tableView.loadMoreView.alpha = 0;
        
        UIView *kongView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        tableView.tableFooterView = kongView;
        [_tableArray addObject:tableView];
        
        UILabel *nothingLab = [self creatMyLabel:nothingsArray[i] frame:CGRectMake(20, 100, ScreenWidth - 40, 50) afloat:13 aview:tableView withColorStr:@"a6a6a7"];
        nothingLab.numberOfLines = 0;
        nothingLab.textAlignment = NSTextAlignmentCenter;
        nothingLab.alpha = 0;
        [_nothingArray addObject:nothingLab];
    }
    
    if (!_request[0]) {
        [self refreshDataWithIndex:0];
    }
    
    UIView *panView = [[UIView alloc] initWithFrame:CGRectMake(0, NaviHeight, 8, ScreenHeight - NaviHeight)];
    panView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:panView];

    
}


- (void)btnClick:(UIButton *)btn {
    if (!_request[btn.tag]) {
        [self refreshDataWithIndex:(int)btn.tag];
    }
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.contentOffset = CGPointMake(btn.frame.origin.x * _btnArr.count, 0);
    }];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *dataArray = [_totalArray objectAtIndex:tableView.tag];
    UILabel *nothingLab = [_nothingArray objectAtIndex:tableView.tag];
    if (dataArray.count == 0) {
        nothingLab.hidden = NO;
    } else {
        nothingLab.hidden = YES;
    }
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSMutableArray *dataArray = [_totalArray objectAtIndex:tableView.tag];
    NewsInfo *info = [dataArray objectAtIndex:indexPath.row];

    cell.textLabel.text = info.title;
    
    cell.detailTextLabel.text = info.time;
    
    return  cell;
  
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger tag  =  (int)tableView.tag;

    NSMutableArray *dataArray = [_totalArray objectAtIndex:tag];
     NewsInfo  *newsInfo  =   dataArray[indexPath.row];
    
    NSString  *ntypeId = @"";
    
    switch (tag) {
        case 0:
            
            ntypeId = @"10003118";
            
            break;
            
        case 1:
            
            ntypeId = @"10003119";
            
            break;
            
        case 2:
            ntypeId = @"100000001";
            break;
            
        case 3:
            ntypeId = @"100000202";
            break;
            
        default:
            break;
    }

    

    if (nil != newsInfo) {
        
        
        NewsDetailViewController  *newsDetailVC  = [[NewsDetailViewController alloc] init];
        newsDetailVC.title = @"资讯详情";
        newsInfo.ntype  = ntypeId;
        newsInfo.npage = @"1";
        
        newsDetailVC.newsInfo = newsInfo;
        
        newsDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newsDetailVC animated:YES];
    }

}



#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *dataArray = [_totalArray objectAtIndex:tableView.tag];
    NewsInfo *info = [dataArray objectAtIndex:indexPath.row];
    CGSize size = [info.time mm_sizeWithFont:15 withWidth:ScreenWidth - 65];
    size.height += 29;
    return size.height;
}


#pragma mark - PullTableViewDelagate

- (void)didGetCommonSuccess:(MMRequestManager *)manager infoDic:(NSDictionary *)dic andManagerTag:(NSInteger)tag
{
    
   
    
    
   BaseResponse  *baseResponse = [[BaseResponse alloc] initWithObjectFormDict:dic];
    
    
     NSMutableArray  *carsArry = [[NSMutableArray alloc] init];
    
    
    
    if (baseResponse.status == 1000) {
        
        NSArray  *mydataAry  = [TDevice parseDictWithAry:[baseResponse.data objectForKey:@"list"]];
            
            
            for (NSDictionary  *mdict  in mydataAry) {
                BOOL shouldBeAdded = YES;
                NewsInfo  *carInfo = [[NewsInfo alloc] initWithObjectFormDict:mdict];
                
                for (NewsInfo *tempCars in carsArry) {
                    if ([carInfo isEqual:tempCars]) {
                        shouldBeAdded = NO;
                        break;
                    }
                    
                }
                
                if (shouldBeAdded) {
                    [carsArry addObject:carInfo];
                    
                }
                
                
            }
    }
    
    NSArray  *array = [carsArry copy];
    
  
    UILabel *nothingLab = [_nothingArray objectAtIndex:tag];
    nothingLab.alpha = 1;
    PullTableView *tableView = [_tableArray objectAtIndex:tag];
    NSMutableArray *dataArray = [_totalArray objectAtIndex:tag];
    
    
    
    
    if (!tableView.pullTableIsLoadingMore) {
        [dataArray removeAllObjects];
        if (array.count > 0) {
            [dataArray addObjectsFromArray:array];
        }
        [tableView reloadData];
    } else if (array.count > 0) {
        NSMutableArray *insertArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < array.count; i ++) {
            [insertArr addObject:[NSIndexPath indexPathForRow:dataArray.count + i inSection:1]];
        }
        [dataArray addObjectsFromArray:array];
        [tableView insertRowsAtIndexPaths:insertArr withRowAnimation:UITableViewRowAnimationNone];
    }
    [self doneFinish:[NSString stringWithFormat:@"%d", manager.tag]];
        if (!baseResponse.hasNext) {
            tableView.hasLoadAll = NO;
        } else {
            tableView.hasLoadAll = YES;
        }
    if ([_requestArray containsObject:manager]) {
        [_requestArray removeObject:manager];
    }



}

- (void)didGetCommonFail:(MMRequestManager *)manager errorStr:(NSString *)errorStr andManagerTag:(NSInteger)tag
{
    [self showFailMBP:errorStr];
    [self performSelector:@selector(doneFinish:) withObject:[NSString stringWithFormat:@"%d", manager.tag] afterDelay:0.1];
    if ([_requestArray containsObject:manager]) {
        [_requestArray removeObject:manager];
    }

}



- (void)doneFinish:(NSString *)tagIndex {
    int index = [tagIndex intValue];
    PullTableView *tableView = [_tableArray objectAtIndex:index];
    tableView.pullTableIsRefreshing = NO;
    tableView.pullTableIsLoadingMore = NO;
    tableView.hasLoadAll = YES;
    tableView.loadMoreView.alpha = 0;
}




#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        
        _moveView.center = CGPointMake((_scrollView.contentOffset.x + ScreenWidth / 2) / _btnArr.count, _moveView.center.y);
        int index = (scrollView.contentOffset.x + ScreenWidth / 2) / ScreenWidth;
        if (index > (int)_btnArr.count - 1) {
            index = (int)_btnArr.count - 1;
        }
        
        for (int i = 0; i < _btnArr.count; i ++) {
            UIButton *btn = [_btnArr objectAtIndex:i];
            if (i == index) {
                [btn setTitleColor:[UIColor colorFromHexRGB:XIAN_BLUE] forState:UIControlStateNormal];
            } else {
                [btn setTitleColor:[UIColor colorFromHexRGB:@"777777"] forState:UIControlStateNormal];
            }
        }
        if (index > 0 && !_request[index - 1] && index * ScreenWidth - scrollView.contentOffset.x > 20) {
            [self refreshDataWithIndex:index - 1];
        }
        if (!_request[index + 1] && scrollView.contentOffset.x - index * ScreenWidth > 20) {
            [self refreshDataWithIndex:index + 1];
        }
    }
}

- (void)refreshDataWithIndex:(int)index {
    _request[index] = YES;
    if (index < _tableArray.count) {
        PullTableView *tableView = [_tableArray objectAtIndex:index];
        tableView.pullTableIsRefreshing = YES;
    }
}


#pragma mark - PullTableViewDelagate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView {
    if (![TDevice isNetworkExist]) {
        [self performSelector:@selector(doneFinish:) withObject:[NSString stringWithFormat:@"%d", (int)pullTableView.tag] afterDelay:0.3];
        [self showMBP:NO_WAN_CONNECT];
        return;
    }
    for (int i = (int)_requestArray.count - 1; i >= 0; i --) {
        MMRequestManager *manager = [_requestArray objectAtIndex:i];
        if (manager.tag == pullTableView.tag) {
            manager.delegate = nil;
            [_requestArray removeObject:manager];
        }
    }
    
    NSInteger tag  =  (int)pullTableView.tag;
    
    NSString  *urlStr = @"";
   
    switch (tag) {
        case 0:
            
            urlStr = @"http://m.sojex.cn/api.do?&rtp=NewsListV2&ntype=10003118&page=1";
            
            break;
            
        case 1:
            
            urlStr = @"http://m.sojex.cn/api.do?&rtp=NewsListV2&ntype=10003119&page=1";
            
            break;
            
        case 2:
            urlStr = @"http://m.sojex.cn/api.do?&rtp=NewsListV2&ntype=100000001&page=1";
            break;
            
        case 3:
            urlStr = @"http://m.sojex.cn/api.do?&rtp=NewsListV2&ntype=100000202&page=1";
            break;
        
        default:
            break;
    }
    
    

    MMRequestManager *manager = [[MMRequestManager alloc] init];
    manager.tag = (int)pullTableView.tag;
    [_requestArray addObject:manager];
    [manager startRequestDeletate:self urlString:urlStr parameters:nil andHttpType:HttpRequestTypeCommon];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView {
    if (![TDevice isNetworkExist]) {
        [self performSelector:@selector(doneFinish:) withObject:[NSString stringWithFormat:@"%d", (int)pullTableView.tag] afterDelay:0.3];
        [self showMBP:NO_WAN_CONNECT];
        return;
    }
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)beginRefresh
{

   
    if (!_request[0]) {
        [self refreshDataWithIndex:0];
    }

}
@end
