//
//  NoticeNewsController.m
//  TraderApp
//
//  Created by tao song on 17/5/5.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "NoticeNewsController.h"
#import <MJRefresh.h>
#import "BaseResponse.h"
#import "RealNewsInfo.h"
#import "NoPictureNewsTableViewCell.h"
#import "TDevice.h"
#import <Reachability.h>

static NSString * const NoPictureCell = @"NoPictureCell";

@interface NoticeNewsController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView *noticeTableView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic,strong) NSMutableArray *noticeArray;
@property(nonatomic,assign)BOOL update;
@end

@implementation NoticeNewsController

- (instancetype)init
{

    self = [super init];

    if (self) {
        self.noticeArray = [[NSMutableArray alloc] init];
    }

    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self setupRefresh];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.update == YES) {
        [self.noticeTableView.mj_header beginRefreshing];
        self.update = NO;
    }
    
  //  [self startTimmerToGetData];
}

- (void)setupBasic
{
    _noticeTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_noticeTableView];
    _noticeTableView.delegate = self;
    _noticeTableView.dataSource = self;
   //  self.automaticallyAdjustsScrollViewInsets = NO;
    self.noticeTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
   self.noticeTableView.scrollIndicatorInsets = UIEdgeInsetsMake(104, 0, 0, 0);
    [self.noticeTableView registerNib:[UINib nibWithNibName:NSStringFromClass([NoPictureNewsTableViewCell class]) bundle:nil] forCellReuseIdentifier:NoPictureCell];

}


#pragma mark --private Method--初始化刷新控件
-(void)setupRefresh {
    self.noticeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.noticeTableView.mj_header.automaticallyChangeAlpha = YES;
    [self.noticeTableView.mj_header beginRefreshing];
    self.noticeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.currentPage = 1;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
  //   [self  stopTimmerToGetData];
    
}


#pragma mark - /************************* 刷新数据 ***************************/
// ------下拉刷新
- (void)loadData
{
    self.currentPage = 1;
    NSString *allUrlstring = [NSString stringWithFormat:@"http://m.sojex.cn/api.do?&rtp=RealTime&page=%ld",self.currentPage] ;
    [self loadDataForType:1 withURL:allUrlstring];
}



- (void)loadMoreData
{
    NSString *allUrlstring = [NSString stringWithFormat:@"http://m.sojex.cn/api.do?&rtp=RealTime&page=%ld",++self.currentPage];
    [self loadDataForType:2 withURL:allUrlstring];
}


- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring
{
   
      AFHTTPRequestOperationManager *manager =    [AFHTTPRequestOperationManager WXManager];
    
    [manager GET:allUrlstring parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString *jsonString = [[NSString alloc] initWithData:responseObject
                                                     encoding:NSUTF8StringEncoding];
        
        NSDictionary *dictJson =  [JSONTools parseJsonFromStringOrObject:jsonString];
        
        
        BaseResponse  *baseResponse = [[BaseResponse alloc] initWithObjectFormDict:dictJson];
        
        
        NSMutableArray  *carsArry = [[NSMutableArray alloc] init];

        
        if (baseResponse.status == 1000) {
            
            NSArray  *mydataAry  = [TDevice parseDictWithAry:baseResponse.data ];
            
            
            for (NSDictionary  *mdict  in mydataAry) {
                BOOL shouldBeAdded = YES;
                RealNewsInfo  *carInfo = [[RealNewsInfo alloc] initWithObjectFormDict:mdict];
                
                for (RealNewsInfo *tempCars in carsArry) {
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
        
        if (type == 1) {
            self.noticeArray = [array mutableCopy];
            [self.noticeTableView.mj_header endRefreshing];
            [self.noticeTableView reloadData];
        }else if(type == 2){
            [self.noticeArray addObjectsFromArray:array];
            
            [self.noticeTableView.mj_footer endRefreshing];
            [self.noticeTableView reloadData];
        }

        
        
        
        

        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];

}




#pragma mark -UITableViewDataSource 返回tableView有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark -UITableViewDataSource 返回tableView每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.noticeArray.count;
}


#pragma mark -UITableViewDataSource 返回indexPath对应的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     RealNewsInfo *NewsModel = self.noticeArray[indexPath.row];
    
    NoPictureNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NoPictureCell];
   

    cell.realNewsInfo = NewsModel;


    return cell;

    
}

//#pragma mark - UITableViewDelegate & UITableViewDataSource
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//  
//     RealNewsInfo *NewsModel = self.noticeArray[indexPath.row];
//    CGSize size = [NewsModel.rcontent mm_sizeWithFont:15 withWidth:ScreenWidth - 65];
//      size.height += 40;
//      return size.height;
//}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RealNewsInfo *NewsModel = self.noticeArray[indexPath.row];
    CGSize size = [NewsModel.rcontent mm_sizeWithFont:15 withWidth:ScreenWidth - 65];
    size.height += 40;
    return size.height;

    
  // NoPictureNewsTableViewCell *nextCell = [tableView cellForRowAtIndexPath:indexPath];


}


//
//
///*********************************************开启定时器轮询请求**************************************************/
//
//static BOOL isPollingStarted = NO;
//static NSTimer *timer;
//static Reachability *reachability;
//
//
//
//- (void)initTimmerToGetData
//{
//    
//    if (isPollingStarted) {
//        return;
//    } else {
//        NSTimeInterval  timmer =10;
//        timer = [NSTimer scheduledTimerWithTimeInterval:timmer target:self selector:@selector(timerUpdate) userInfo:nil repeats:YES];
//          
//        reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
//        isPollingStarted = YES;
//    }
//    
//    
//    
//    
//}
//
///*+++++++START+++++++++++ 地图生命周期+++++++++++++++++++++++++++*/
//
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    
//    [self startTimmerToGetData];
//}
//
//
//
//
//
//- (void)timerUpdate
//{
//    NSLog(@"======timerUpdate=======");
//    
//    if (reachability.currentReachabilityStatus == 0) {return;}
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//       
//        [self loadData];
//        
//    });
//}
//
//
//- (void)startTimmerToGetData
//{
//    
//    
//    if (timer) {
//        
//        [timer fire];
//    } else {
//        isPollingStarted = NO;
//        [self initTimmerToGetData];
//    }
//    
//    
//    
//    
//    
//    
//}
//
//
//- (void)stopTimmerToGetData
//{
//    
//    
//    if (timer && [timer isValid]) {
//        [timer invalidate];
//        isPollingStarted = NO;
//        timer = nil;
//    }
//    
//}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
