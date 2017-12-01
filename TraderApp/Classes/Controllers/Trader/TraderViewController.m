

#import "TraderViewController.h"
#import "AdveriseViewController.h"
#import "TDevice.h"
#import "BaseResponse.h"
#import "SDCycleScrollView.h"
#import "TraderBannerInfo.h"
#import "AboutMeController.h"
#import "UUMarqueeView.h"
#import "ProductView.h"
#import "RecommendCaseView.h"
#import <Reachability.h>


@interface TraderViewController() <SDCycleScrollViewDelegate,UUMarqueeViewDelegate>

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) NSMutableArray *bannerImages;
@property (nonatomic, strong) UUMarqueeView *simpleMarqueeView;
@property (nonatomic,strong) UIScrollView  *traderScrollView;
@property (nonatomic,strong) NSMutableArray *dataTraderSources;
@property (nonatomic, strong) UIView *productContainerView;
@property (nonatomic,strong)  UIView *myselectProductView;
@property (nonatomic,strong) UIView *mySelectProduct;

@end

@implementation TraderViewController
{

    UIView  *broadView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bannerImages = [[NSMutableArray alloc] init];
        _dataTraderSources  = [[NSMutableArray alloc] init];
    }
    return self;
}


// 刷新方法
- (void)refreshCurrentViewController
{
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initAdverise];
    
    // 初始化Bannner
    [self initBanner];
    
    // 初始化广播
    [self initBroadCast];
    
    // 初始化产品
    [self initProductView];
    
    // 请求获取产品
    [self  requestProductInfo];
    
    
    [self  initSelectProduct];

}




// 广告初始化
- (void)initAdverise
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAdverise) name:kAdveriseNotice object:nil];
}

/*********************************************广告**************************************************/
- (void)pushToAdverise {
    
    
    AdveriseViewController *adVc = [[AdveriseViewController alloc] init];
    adVc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:adVc animated:YES];
    
}

/*********************************************轮播广告**************************************************/
- (void)initBanner
{

    _traderScrollView  = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _traderScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    _traderScrollView.showsVerticalScrollIndicator = NO;
    _traderScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_traderScrollView];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, OSC_BANNER_HEIGHT) delegate:self placeholderImage:[UIImage imageNamed:@"loading_01"]];
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView.currentPageDotColor = [UIColor redColor]; // 自定义分页控件小圆标颜色
    [_traderScrollView addSubview:_cycleScrollView];

    _bannerImages = [TDevice getBannerData];
   NSMutableArray  *imageUrlAry = [[NSMutableArray alloc] init];
    
    for (TraderBannerInfo *traderIndex  in _bannerImages) {
        
        [imageUrlAry addObject: traderIndex.img];
    }
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cycleScrollView.imageURLStringsGroup = [imageUrlAry copy];
        
    });
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    TraderBannerInfo  *traderIndex =    _bannerImages[index];
    
    
    AboutMeController *controller = [[AboutMeController alloc] init];
    
    controller.title = traderIndex.name;
    controller.webUrl = traderIndex.href;
    controller.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:controller animated:YES];
    
    
}



/*********************************************公告**************************************************/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_simpleMarqueeView) {
        [_simpleMarqueeView start];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (_simpleMarqueeView) {
        [_simpleMarqueeView pause];
    }
   
}

- (void)initBroadCast
{
    
    broadView = [[UIView alloc] init];
    [broadView setBackgroundColor:[UIColor whiteColor]];
    [_traderScrollView addSubview:broadView];

    [broadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_cycleScrollView.mas_bottom).offset(5);
        make.left.mas_equalTo(_traderScrollView.mas_left);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(@40);
    }];
 
    UIView *hLineView = [[UIView alloc] init];
    [hLineView setBackgroundColor:[UIColor lightGrayColor]];
    [broadView addSubview:hLineView];
    
    [hLineView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(broadView.mas_top);
        make.left.mas_equalTo(_traderScrollView.mas_left);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(@1);
    }];
    
    
    
    
    UILabel  *broadTitle = [[UILabel alloc] init];
    [broadTitle setFont:[UIFont systemFontOfSize:13.0f]];
    [broadTitle setText:@" 公告 :"];
    [broadTitle setTextColor:[UIColor blackColor]];
    [broadTitle setTextAlignment:NSTextAlignmentLeft];
    [broadView addSubview:broadTitle];
    
    
    [broadTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hLineView.mas_top);
        make.left.mas_equalTo(hLineView.mas_left).offset(10);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@38);
    }];
    
    
    _simpleMarqueeView = [[UUMarqueeView alloc] initWithFrame:CGRectMake(60, 1, ScreenWidth, 37)];
    [_simpleMarqueeView setBackgroundColor:[UIColor lightGrayColor]];
    [broadView addSubview:_simpleMarqueeView];
    
    _simpleMarqueeView.delegate = self;
    _simpleMarqueeView.timeIntervalPerScroll = 3.0f;
    _simpleMarqueeView.timeDurationPerScroll = 2.0f;
    
    [_simpleMarqueeView reloadData];
    
    
    
    UIView *hLineView2 = [[UIView alloc] init];
    [hLineView2 setBackgroundColor:[UIColor lightGrayColor]];
    [broadView addSubview:hLineView2];
    
    [hLineView2  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_simpleMarqueeView.mas_bottom);
        make.left.mas_equalTo(_traderScrollView.mas_left);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(@1);
    }];
    
    
    
    
}

#pragma mark -- UUMarqueeViewDelegate
- (NSInteger)numberOfVisibleItemsForMarqueeView:(UUMarqueeView*)marqueeView {
    
    return 1;
}

- (NSArray*)dataSourceArrayForMarqueeView:(UUMarqueeView*)marqueeView {
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"现在时间是  YYYY年MM月dd日 HH:mm"];
    NSString *dateString =[dateFormatter stringFromDate:currentDate];
   
    return @[@"欢迎使用本系统！",
             dateString,
             @"系统处于试应用中！"];
    
}

- (void)updateItemView:(UIView*)itemView withData:(id)data forMarqueeView:(UUMarqueeView*)marqueeView {
    
    UILabel *content = [itemView viewWithTag:1001];
    [content setTextColor:[UIColor redColor]];
    content.text = data;
}

- (void)createItemView:(UIView*)itemView forMarqueeView:(UUMarqueeView*)marqueeView {
    
    itemView.backgroundColor = [UIColor whiteColor];
    
    UILabel *content = [[UILabel alloc] initWithFrame:itemView.bounds];
    content.font = [UIFont systemFontOfSize:12.0f];
    content.tag = 1001;
    [content setTextColor:[UIColor redColor]];
    [itemView addSubview:content];
}

/*********************************************国际产品**************************************************/

- (void)initProductView
{

    _productContainerView  = [[UIView alloc] init];
    [_productContainerView setBackgroundColor:[UIColor lightGrayColor]];
    [_traderScrollView addSubview:_productContainerView];

    [_productContainerView  mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(_traderScrollView.mas_left);
        make.top.mas_equalTo(broadView.mas_bottom);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(@90);
    }];
    

    UIView *hLineView3 = [[UIView alloc] init];
    [hLineView3 setBackgroundColor:[UIColor lightGrayColor]];
    [broadView addSubview:hLineView3];
    
    [hLineView3  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_productContainerView.mas_bottom);
        make.left.mas_equalTo(_traderScrollView.mas_left);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(@1);
    }];
}




- (void)requestProductInfo
{

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProductView:) name:TRADER_DATA_UPDATE object:nil];
    
    AFHTTPRequestOperationManager  *manager  = [AFHTTPRequestOperationManager WXManager];
    
    [manager GET:TRADER_PRICE_URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        
        NSString *jsonString = [[NSString alloc] initWithData:responseObject
                                                     encoding:NSUTF8StringEncoding];
        
        NSDictionary *dictJson =  [JSONTools parseJsonFromStringOrObject:jsonString];
        
        BaseResponse  *baseResponse = [[BaseResponse alloc] initWithObjectFormDict:dictJson];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        if (baseResponse.status == 1000) {
            
            NSArray  *myArray  = [TDevice parseDictWithAry:baseResponse.data];
            
            for (NSDictionary *dict in myArray) {
                
                ProductInfo  *pruductInfo = [[ProductInfo alloc] initWithObjectFormDict:dict];
                
                BOOL shouldBeAdded = YES;
                
                for (ProductInfo *tempCars in tempArray) {
                    if ([pruductInfo isEqual:tempCars]) {
                        shouldBeAdded = NO;
                        break;
                    }
                    
                }
                
                if (shouldBeAdded) {
                    [tempArray addObject:pruductInfo];
                    
                }
                
            }
            
            
            
        }else {
            
            
        }
        
        
        if (tempArray.count >0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:TRADER_DATA_UPDATE object:tempArray];
        }
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
    
}


- (void)updateProductView:(NSNotification *)noti
{
    
    
    _dataTraderSources  =  noti.object;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TRADER_DATA_UPDATE object:nil];
    
    for (int i = 0; i < _dataTraderSources.count; i++) {
        
       ProductView  *itemView =  [[ProductView alloc] init];
        [itemView setBackgroundColor:[UIColor whiteColor]];
        
         ProductInfo  *productInfo = _dataTraderSources[i];
        
        [itemView.pnameLabel setText:productInfo.name];
        [itemView.pdescLabel setTextColor:[UIColor colorFromHexRGB:productInfo.color]];
        [itemView.pdescLabel setText:[NSString stringWithFormat:@"%.3lf",productInfo.sell]];
        
        [itemView.traderLabel setText:[productInfo.pmp stringByAppendingString:@"%"]];
      
        [_productContainerView addSubview:itemView];
        
    }
    
    [_productContainerView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
    withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    
    [_productContainerView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
       UIView *itemView =  _productContainerView.subviews[0];
        make.top.mas_equalTo(_productContainerView.mas_top);
        make.width.mas_equalTo(itemView.mas_width);
        make.height.mas_equalTo(_productContainerView.mas_height);
    }];
    
    
 //   [self updateProductWay];
   
    
    
    
    if (_dataTraderSources.count <=0) {
        return;
        
        
        
    }
    
    [_mySelectProduct reloadInputViews];
    
    for (int i = 0; i < _dataTraderSources.count; i++) {
        
        RecommendCaseView  *itemView =  [[RecommendCaseView alloc] init];
        [itemView setBackgroundColor:[UIColor whiteColor]];
        
        ProductInfo  *productInfo = _dataTraderSources[i];
        
        [itemView.pnameLabel setText:productInfo.name];
        [itemView.pwaysLabel setText:[NSString stringWithFormat:@"趋势: 做多"]];
        [itemView.pwaysLabel setTextColor:[UIColor colorFromHexRGB:productInfo.color]];
        [itemView.zhiliLabel setText:[NSString stringWithFormat:@"阴力位: %.3lf",productInfo.sell]];
        
        [itemView.zhichengLabel setText:[NSString stringWithFormat:@"支撑位: %.3lf",productInfo.sell]];
        
        [_mySelectProduct addSubview:itemView];
        
    }
    
    [_mySelectProduct.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                           withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    
    [_mySelectProduct.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *itemView =  _mySelectProduct.subviews[0];
        make.top.mas_equalTo(_mySelectProduct.mas_top);
        make.width.mas_equalTo(itemView.mas_width);
        make.height.mas_equalTo(_mySelectProduct.mas_height);
    }];
    
    

}


- (void)initSelectProduct
{

   _myselectProductView = [[UIView alloc] init];
    //[_myselectProductView setBackgroundColor:[UIColor lightGrayColor]];
    [_traderScrollView addSubview:_myselectProductView];


    
    [_myselectProductView  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(_traderScrollView.mas_left);
        make.top.mas_equalTo(_productContainerView.mas_bottom).offset(10);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeight*0.4);
    }];
    
    
    
    UIView *hLineView2 = [[UIView alloc] init];
    [hLineView2 setBackgroundColor:[UIColor lightGrayColor]];
    [_myselectProductView addSubview:hLineView2];
    
    [hLineView2  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_myselectProductView.mas_top).offset(5);
        make.left.mas_equalTo(_traderScrollView.mas_left);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(@1);
    }];
    

    
    
    UILabel  *broadTitle = [[UILabel alloc] init];
    [broadTitle setFont:[UIFont systemFontOfSize:13.0f]];
    [broadTitle setText:@" 参考策略"];
   // [broadTitle setBackgroundColor:[UIColor whiteColor]];
    [broadTitle setTextColor:[UIColor blackColor]];
    [broadTitle setTextAlignment:NSTextAlignmentLeft];
    [_myselectProductView addSubview:broadTitle];
    
    
    [broadTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hLineView2.mas_top);
        make.left.mas_equalTo(_myselectProductView.mas_left).offset(10);
        make.width.mas_equalTo(_myselectProductView.mas_width);
        make.height.mas_equalTo(@36);
    }];
    
    UIView *hLineView3 = [[UIView alloc] init];
    [hLineView3 setBackgroundColor:[UIColor lightGrayColor]];
    [_myselectProductView addSubview:hLineView3];
    
    [hLineView3  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(broadTitle.mas_bottom).offset(2);
        make.left.mas_equalTo(_traderScrollView.mas_left);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(@1);
    }];
    
    
   _mySelectProduct =  [[UIView alloc] init];
    [_mySelectProduct setBackgroundColor:[UIColor lightGrayColor]];
   [_myselectProductView addSubview:_mySelectProduct];
    
    [_mySelectProduct mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hLineView3.mas_bottom).offset(5);
        make.left.mas_equalTo(_myselectProductView.mas_left);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(@120);
    }];
    
    
    
    UIView *hLineView4 = [[UIView alloc] init];
    [hLineView4 setBackgroundColor:[UIColor lightGrayColor]];
    [_myselectProductView addSubview:hLineView4];
    
    [hLineView4  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mySelectProduct.mas_bottom).offset(2);
        make.left.mas_equalTo(_traderScrollView.mas_left);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(@1);
    }];
}

- (void)updateProductWay
{

    if (_dataTraderSources.count <=0) {
        return;
    }

    for (int i = 0; i < _dataTraderSources.count; i++) {
        
        RecommendCaseView  *itemView =  [[RecommendCaseView alloc] init];
        [itemView setBackgroundColor:[UIColor whiteColor]];
        
        ProductInfo  *productInfo = _dataTraderSources[i];
        
        [itemView.pnameLabel setText:productInfo.name];
        [itemView.pwaysLabel setText:[NSString stringWithFormat:@"趋势: 做多"]];
        [itemView.pwaysLabel setTextColor:[UIColor colorFromHexRGB:productInfo.color]];
        [itemView.zhiliLabel setText:[NSString stringWithFormat:@"阴力位: %.3lf",productInfo.sell]];
        
        [itemView.zhichengLabel setText:[NSString stringWithFormat:@"支撑位: %.3lf",productInfo.sell]];
        
        [_mySelectProduct addSubview:itemView];
        
    }
    
    [_mySelectProduct.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                                withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    
    [_mySelectProduct.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *itemView =  _mySelectProduct.subviews[0];
        make.top.mas_equalTo(_mySelectProduct.mas_top);
        make.width.mas_equalTo(itemView.mas_width);
        make.height.mas_equalTo(_mySelectProduct.mas_height);
    }];

    




}



/*********************************************开启定时器轮询请求**************************************************/

static BOOL isPollingStarted = NO;
static NSTimer *timer;
static Reachability *reachability;



- (void)initTimmerToGetData
{
    
    if (isPollingStarted) {
        return;
    } else {
        NSTimeInterval  timmer =10;
        timer = [NSTimer scheduledTimerWithTimeInterval:timmer target:self selector:@selector(timerUpdate) userInfo:nil repeats:YES];
        
        reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        isPollingStarted = YES;
    }
    
    
    
    
}

/*+++++++START+++++++++++ 地图生命周期+++++++++++++++++++++++++++*/

-(void)viewDidAppear:(BOOL)animated
                    {
    [super viewDidAppear:animated];

   // [self startTimmerToGetData];
}



-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   //    [self  stopTimmerToGetData];
}



- (void)timerUpdate
{
    NSLog(@"============");
    
    if (reachability.currentReachabilityStatus == 0) {return;}
    
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
                [self requestProductInfo];
            
        });
}


- (void)startTimmerToGetData
{
    
    
    if (timer) {
        
        [timer fire];
    } else {
        isPollingStarted = NO;
        [self initTimmerToGetData];
    }
    
    
    
    
    
    
}


- (void)stopTimmerToGetData
{
    
    
    if (timer && [timer isValid]) {
        [timer invalidate];
        isPollingStarted = NO;
        timer = nil;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
