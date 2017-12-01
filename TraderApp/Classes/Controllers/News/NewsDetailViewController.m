//
//  NewsDetailViewController.m
//  TraderApp
//
//  Created by tao song on 17/5/5.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "TDevice.h"
#import "NewsDetailInfo.h"

@interface NewsDetailViewController ()
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *issueButton;
@property (nonatomic,strong) UILabel *sourceMediaLabel;
@property (nonatomic,strong) UIWebView *contentWebView;

@end

@implementation NewsDetailViewController
{
    //右边按钮
    UIButton *m_RightBtn;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionButton];
    [self addNewsDetailView];
    [self initLayoutUI];
    [self requestNewsDetail];
   
}

- (void)initCollectionButton
{

    //自定义一个导航条右上角的一个button
    UIImage *issueImage = [UIImage imageNamed:@"ic_faved_normal"];
    
    self.issueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_issueButton setBackgroundColor:[UIColor clearColor]];
    
    _issueButton.selected =[TDevice isExitObj:_newsInfo];
    
    self.issueButton.frame = CGRectMake(0, 0, issueImage.size.width, issueImage.size.height);
    [_issueButton setBackgroundImage:issueImage forState:UIControlStateNormal];
     [_issueButton setBackgroundImage:[UIImage imageNamed:@"ic_faved_pressed"] forState:UIControlStateHighlighted];
    
      [_issueButton setBackgroundImage:[UIImage imageNamed:@"ic_faved_pressed"] forState:UIControlStateSelected];
    
    [_issueButton addTarget:self action:@selector(issueBton:) forControlEvents:UIControlEventTouchUpInside];
   
    //添加到导航条
    UIBarButtonItem *leftBarButtomItem = [[UIBarButtonItem alloc]initWithCustomView:_issueButton];
    self.navigationItem.rightBarButtonItem = leftBarButtomItem;


}

- (void)issueBton:(UIButton *)button
{
    button.selected  =!button.selected;
    
    [TDevice saveNewsCollectionWith:_newsInfo];
}










- (void)addNewsDetailView
{
    
    _mainScrollView  = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _mainScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    
    
//     _titleLabel  = [[UILabel alloc] init];
//  
//    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
//    [_mainScrollView addSubview:_titleLabel];
//
//
//    _sourceMediaLabel  = [[UILabel alloc] init];
//    
//    [_sourceMediaLabel setFont:[UIFont systemFontOfSize:15.0f]];
//    
//    [_sourceMediaLabel setTextAlignment:NSTextAlignmentLeft];
//    [_mainScrollView addSubview:_sourceMediaLabel];
    
    _contentWebView = [[UIWebView alloc] init];
    _contentWebView.scrollView.bounces = NO;
    _contentWebView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [_mainScrollView addSubview:_contentWebView];
    
}




- (void)initLayoutUI
{
//    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_mainScrollView.mas_top).offset(10);
//        make.left.mas_equalTo(self.view.mas_left).offset(5);
//        make.right.mas_equalTo(self.view.mas_right).offset(-5);
//     //   make.height.mas_equalTo(@80);
//    }];
//    
//    
//    [_sourceMediaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
//        make.left.mas_equalTo(self.view.mas_left).offset(10);
//        make.right.mas_equalTo(self.view.mas_right).offset(-10);
//        make.height.mas_equalTo(@40);
//    }];
//   
    
    [_contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mainScrollView.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeight);
    }];
}


- (void)requestNewsDetail
{

    if (nil ==_newsInfo) {
        
        return;
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNewsDetailView:) name:NEWS_DATA_UPDATE object:nil];
    
    MBProgressHUD *HUD = [TDevice createHUD];
    HUD.label.text = @"正在获取数据中...";

    
    AFHTTPRequestOperationManager  *manager = [AFHTTPRequestOperationManager WXManager];

    NSString *requestUrl = [NSString stringWithFormat:@"http://m.sojex.cn/api.do?&rtp=NewsContentV2&ntype=%@&id=%@&page=%@",_newsInfo.ntype,_newsInfo.nId,_newsInfo.npage];

    [manager  GET:requestUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString *jsonString = [[NSString alloc] initWithData:responseObject
                                                     encoding:NSUTF8StringEncoding];
        
        NSDictionary *dictJson =  [JSONTools parseJsonFromStringOrObject:jsonString];
        
        BaseResponse  *baseResponse = [[BaseResponse alloc] initWithObjectFormDict:dictJson];
        NewsDetailInfo *newsDetailInfo = nil;
        
        if (baseResponse.status == 1000) {
             [HUD hideAnimated:YES afterDelay:1];
            
             newsDetailInfo = [[NewsDetailInfo alloc] initWithObjectFormDict:baseResponse.data];
       
            
            
        }else {
        
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.label.text = @"解析数据异常！";
            
            [HUD hideAnimated:YES afterDelay:1];
        }
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NEWS_DATA_UPDATE object:newsDetailInfo];
        

        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NEWS_DATA_UPDATE object:nil];
        
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.label.text = @"网络异常，获取数据失败！";
        
        [HUD hideAnimated:YES afterDelay:1];
    }];
}

- (void)updateNewsDetailView:(NSNotification *)noti
{

    NewsDetailInfo  *newsDetail  = noti.object;

    
    if (nil != newsDetail) {
     
        NSString *newsDetailTitle = newsDetail.ntitle;
        
        NSString *newsDetailMedia = newsDetail.nmedia;
        
        NSString *newsDetailContent = newsDetail.ncontent;
        
        
//        NSDictionary *attributesDic = [TDevice settingAttributesWithLineSpacing:5 FirstLineHeadIndent:2 * 14 Font:[UIFont fontWithName:@"Helvetica-Bold" size:16.0f] TextColor:[UIColor blackColor]];
//        _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:newsDetailTitle attributes:attributesDic];
//        _titleLabel.numberOfLines = 0;
        
       // [_titleLabel setText:newsDetailTitle];
        
      //  [_sourceMediaLabel setText:newsDetailMedia];
        
        NSString *jsString = [NSString stringWithFormat:@"<html> \n"
                              "<head> \n"
                              "</head> \n"
                              "<body><div style=\"height: 100%%; overflow-y: auto;\"><div style=\"opacity: 1; padding: 8px;\"><h1 style=\"font-size: 50px; font-weight: bold; color: rgb(55, 77, 105);\">%@</h1><p style=\"margin: 12px 0px; color: rgb(105, 105, 105);font-size: 38px;\">%@</p><div style=\"font-size: 38px;\">%@</div></div></div></body> \n"
                              "</html>",newsDetailTitle,newsDetailMedia,newsDetailContent];
        
        [_contentWebView loadHTMLString:jsString baseURL:nil];
        
        
      
        
        
        
    }
    
   [[NSNotificationCenter defaultCenter] removeObserver:self name:NEWS_DATA_UPDATE object:nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
