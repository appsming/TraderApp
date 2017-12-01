//
//  MoreViewController.m
//  TraderApp
//
//  Created by tao song on 17/4/22.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "MoreViewController.h"
#import "FeedBackViewController.h"
#import "AboutMeController.h"
#import "UMSPlatformListViewController.h"
#import "NewsCollectionController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
{

      UIScrollView       *_scrollView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    topView.backgroundColor = [UIColor colorFromHexRGB:XIAN_BLUE];
    [self.view addSubview:topView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight - 20)];
    _scrollView.backgroundColor = self.view.backgroundColor;
    _scrollView.bounces = NO;
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 48, 0);
    [self.view addSubview:_scrollView];
    
       float start_y = 46+10;
    
    
    UIView *bgView0 = [[UIView alloc] initWithFrame:CGRectMake(0, start_y, ScreenWidth, 46 * 2)];
    bgView0.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bgView0];
    
    for (int i = 0; i < 3; i ++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, i * 46, ScreenWidth, LINE_HEIGHT)];
        line.backgroundColor = LINE_COLOR;
        [bgView0 addSubview:line];
    }
    
    [self creatMyBtn:CGRectMake(0, start_y, ScreenWidth, 46) aview:_scrollView tag:1];
    [self creatCenterImageView:CGRectMake(6, start_y, 40, 46) onView:_scrollView imgStr:@"more_collect"];
    [self creatMyLabel:@"我的收藏" frame:CGRectMake(46, start_y, 130, 46) afloat:15 aview:_scrollView withColorStr:@"312f2f"];
    [self creatCenterImageView:CGRectMake(ScreenWidth - 40, start_y, 30, 46) onView:_scrollView imgStr:@"arrow_right"];
    
    start_y += 46;
        
    [self creatMyBtn:CGRectMake(0, start_y, ScreenWidth, 46) aview:_scrollView tag:2];
    [self creatCenterImageView:CGRectMake(6, start_y, 40, 46) onView:_scrollView imgStr:@"more_adverise"];
    [self creatMyLabel:@"意见反馈" frame:CGRectMake(46, start_y, 130, 46) afloat:15 aview:_scrollView withColorStr:@"312f2f"];
    [self creatCenterImageView:CGRectMake(ScreenWidth - 40, start_y, 30, 46) onView:_scrollView imgStr:@"arrow_right"];
//    
//    start_y += 46 + 20;
//
//    
//    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, start_y, ScreenWidth, 46*2)];
//    bgView2.backgroundColor = [UIColor whiteColor];
//    [_scrollView addSubview:bgView2];
//    
//    for (int i = 0; i < 3; i ++) {
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, i * 46, ScreenWidth, LINE_HEIGHT)];
//        line.backgroundColor = LINE_COLOR;
//        [bgView2 addSubview:line];
//    }
//    
//    [self creatMyBtn:CGRectMake(0, start_y, ScreenWidth, 46) aview:_scrollView tag:3];
//    [self creatCenterImageView:CGRectMake(6, start_y, 40, 46) onView:_scrollView imgStr:@"more_share"];
//    [self creatMyLabel:@"我要分享" frame:CGRectMake(46, start_y, 130, 46) afloat:15 aview:_scrollView withColorStr:@"312f2f"];
//    [self creatCenterImageView:CGRectMake(ScreenWidth - 40, start_y, 30, 46) onView:_scrollView imgStr:@"arrow_right"];
//    
  
    
    
    start_y += 46;
    
//    [self creatMyBtn:CGRectMake(0, start_y, ScreenWidth, 46) aview:_scrollView tag:4];
//    [self creatCenterImageView:CGRectMake(6, start_y, 40, 46) onView:_scrollView imgStr:@"more_adverise"];
//    [self creatMyLabel:@"申请注册" frame:CGRectMake(46, start_y, 130, 46) afloat:15 aview:_scrollView withColorStr:@"312f2f"];
//    [self creatCenterImageView:CGRectMake(ScreenWidth - 40, start_y, 30, 46) onView:_scrollView imgStr:@"arrow_right"];
//    
//    start_y += 46 + 20;
    
    
    
    
    UIView *bgView3 = [[UIView alloc] initWithFrame:CGRectMake(0, start_y, ScreenWidth, 46)];
    bgView3.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bgView3];
    
    for (int i = 0; i < 2; i ++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, i * 46, ScreenWidth, LINE_HEIGHT)];
        line.backgroundColor = LINE_COLOR;
        [bgView3 addSubview:line];
    }
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *localVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    [self creatCenterImageView:CGRectMake(6, start_y, 40, 46) onView:_scrollView imgStr:@"more_update"];
    [self creatMyLabel:@"软件版本" frame:CGRectMake(46, start_y, 130, 46) afloat:15 aview:_scrollView withColorStr:@"312f2f"];
    UILabel *versonLabel = [self creatMyLabel:[NSString stringWithFormat:@"v%@",localVersion]  frame:CGRectMake(ScreenWidth - 120, start_y, 97, 46) afloat:15 aview:_scrollView withColorStr:@"312f2f"];
    versonLabel.textAlignment = NSTextAlignmentRight;
    
    start_y += 46 + 20;
    
    UIView *bgView4 = [[UIView alloc] initWithFrame:CGRectMake(0, start_y, ScreenWidth, 46)];
    bgView4.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bgView4];
    
    for (int i = 0; i < 2; i ++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, i * 46, ScreenWidth, LINE_HEIGHT)];
        line.backgroundColor = LINE_COLOR;
        [bgView4 addSubview:line];
    }
    
    [self creatMyBtn:CGRectMake(0, start_y, ScreenWidth, 46) aview:_scrollView tag:5];
    [self creatCenterImageView:CGRectMake(6, start_y, 40, 46) onView:_scrollView imgStr:@"more_about"];
    [self creatMyLabel:@"关于我们" frame:CGRectMake(46, start_y, 130, 46) afloat:15 aview:_scrollView withColorStr:@"312f2f"];
    [self creatCenterImageView:CGRectMake(ScreenWidth - 40, start_y, 30, 46) onView:_scrollView imgStr:@"more_arrow_r"];
    
    start_y += 46 + 20 + 48;
    
    _scrollView.contentSize = CGSizeMake(ScreenWidth, start_y);

}


- (void)btnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 1:{
            
            NewsCollectionController  *newsCollectionVC = [[NewsCollectionController alloc] init];
            newsCollectionVC.title = @"我的收藏";
            newsCollectionVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:newsCollectionVC animated:YES];
            

            break;
        }
            
        case 2:{
         
            
                FeedBackViewController *controller = [[FeedBackViewController alloc] init];
                
                controller.title = @"意见反馈";
                  controller.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:controller animated:YES];
                
            
            }
            
            break;
            
        case 3:
            {
            
                [self shareAction:btn];
            
            }
            
            break;
        case 4:
            break;
            
        case 5:
            
            {//关于我们

                AboutMeController *controller = [[AboutMeController alloc] init];
                
                controller.title = @"关于我们";
                controller.webUrl = @"https://www.baidu.com";
                      controller.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:controller animated:YES];
                
            
            }
            
            break;
        }
            
}



- (void)shareAction:(UIButton *)button
{
   // self.hidesBottomBarWhenPushed=YES;

    UMSPlatformListViewController  *sharePlatformList = [[UMSPlatformListViewController alloc] initWithViewType:UMSAuthViewTypeShare];
    sharePlatformList.hidesBottomBarWhenPushed=YES;
       [self.navigationController pushViewController:sharePlatformList animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
