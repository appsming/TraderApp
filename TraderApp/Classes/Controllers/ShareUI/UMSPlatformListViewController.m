


#import "UMSPlatformListViewController.h"
#import "UMSAuthInfo.h"



static NSString* const UMS_Web_Desc = @"W欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";
static NSString* const UMS_Title = @"【友盟+】社会化组件U-Share";
static NSString *UMS_NAV_TBL_CELL = @"UMS_NAV_TBL_CELL";

@interface UMSAuthCell : UITableViewCell


@property (nonatomic, assign) UMSAuthViewType authType;

@property (nonatomic, strong) UMSAuthInfo *info;
@property (nonatomic, strong) UIButton *authButton;
@property (nonatomic, strong) void (^authOpFinish)();
@property (nonatomic, strong) void (^share)(UMSocialPlatformType type);

@end

@implementation UMSAuthCell

- (instancetype)initWithType:(UMSAuthViewType)type
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UMS_NAV_TBL_CELL]) {
        self.authType = type;
        
    }
    return self;
}


- (void)reloadInfo
{
    if (_info.response) {
        self.authButton.selected = YES;
    } else {
        self.authButton.selected = NO;
    }
}
@end





@interface UMSPlatformListViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *opArray;

@property (nonatomic, assign) UMSAuthViewType authType;

@property (nonatomic, assign) NSInteger authButtonX;

@end

@implementation UMSPlatformListViewController

- (instancetype)initWithViewType:(UMSAuthViewType)type
{
    if (self = [super init]) {
        self.authType = type;
        _authButtonX = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    self.titleString = @"分享";
    
    self.opArray = @[[UMSAuthInfo objectWithType:UMSocialPlatformType_WechatSession],
                     [UMSAuthInfo objectWithType:UMSocialPlatformType_WechatTimeLine],
    
                     [UMSAuthInfo objectWithType:UMSocialPlatformType_QQ],
                     [UMSAuthInfo objectWithType:UMSocialPlatformType_Qzone],
                     [UMSAuthInfo objectWithType:UMSocialPlatformType_Sina],
    
                     ];
    

   
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 0.f, 15.f)];
        
        [self.view addSubview:_tableView];
    }
    _tableView.allowsSelection = YES;
    
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.authButtonX = 0;
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillLayoutSubviews {
    self.tableView.frame = self.view.bounds;
    __weak UMSPlatformListViewController *ws = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ws.authButtonX = 0;
        [ws.tableView reloadData];
    });
}


#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.opArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UMSAuthCell *cell = [self.tableView dequeueReusableCellWithIdentifier:UMS_NAV_TBL_CELL];
    cell.textLabel.textColor = [UIColor colorWithRed:0.34 green:.35 blue:.3 alpha:1];
    
    if (!cell) {
        cell = [[UMSAuthCell alloc] initWithType:_authType];
    }
    
    cell.authOpFinish = ^{
        [tableView reloadData];
    };
    
    CGRect frame = cell.authButton.frame;
    NSInteger x = cell.textLabel.frame.origin.x + cell.textLabel.frame.size.width - frame.size.width - 20.f;
    if (x > _authButtonX) { _authButtonX = x; }
    if (_authButtonX > 0) { frame.origin.x = _authButtonX; }
    cell.authButton.frame = frame;
    
    
    UMSAuthInfo *obj = [_opArray objectAtIndex:indexPath.row];
    cell.info = obj;
    [cell reloadInfo];
    
    NSString *platformName = nil;
    NSString *iconName = nil;
    [UMSocialUIUtility configWithPlatformType:obj.platform withImageName:&iconName withPlatformName:&platformName];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", platformName];
    cell.imageView.image = [UMSocialUIUtility imageNamed:iconName];
    

    return cell;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  UMSAuthInfo *obj = self.opArray[indexPath.row];
   [self shareWebPageToPlatformType:obj.platform];
}

#pragma mark -

- (UIImage *)resizeImage:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, size.width, size.height);
    [image drawInRect:imageRect];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return retImage;
}



//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:UMS_Title descr:UMS_Web_Desc thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = UMS_WebLink;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];

    
    
    
}
     
     
     
     
     - (void)alertWithError:(NSError *)error
    {
        NSString *result = nil;
        if (!error) {
            result = [NSString stringWithFormat:@"Share succeed"];
        }
        else{
            NSMutableString *str = [NSMutableString string];
            if (error.userInfo) {
                for (NSString *key in error.userInfo) {
                    [str appendFormat:@"%@\n", error.userInfo[key]];
                }
            }
            if (error) {
                result = [NSString stringWithFormat:@"分享失败, %d\n%@",(int)error.code, str];
            }
            else{
                result = [NSString stringWithFormat:@"分享失败！"];
            }
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:result
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                              otherButtonTitles:nil];
        [alert show];
    }


@end

