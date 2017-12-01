//
//  AppConfig.h
//  TraderApp
//
//  Created by tao song on 17/4/22.
//  Copyright © 2017年 tao song. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h

#import "UIColor+Util.h"

//static NSString *const adImageName = @"adImageName";
//static NSString *const adUrl = @"adUrl";

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度，兼容性测试

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度，兼容性测试

#define ScreenBounds  [[UIScreen mainScreen] bounds]


#define kUserDefaults [NSUserDefaults standardUserDefaults]


#define kAdveriseNotice  @"kAdveriseNotice"



#define NaviHeight 64
#define NO_WAN_CONNECT @"无网络连接"
//分割线的高度
#define LINE_HEIGHT 0.5


#define XIAN_BLUE  @"#f67d02"

//分割线的背景色
#define LINE_COLOR [UIColor colorWithHex:0xcbcbcb]


#import <UMSocialCore/UMSocialCore.h>
#import <UMengUShare/UShareUI/UShareUI.h>
//#define USHARE_APPKEY @"5861e5daf5ade41326001eab"



static NSString* const UMS_THUMB_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
static NSString* const UMS_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";

static NSString* const UMS_WebLink = @"http://mobile.umeng.com/social";

#define UM_APP_KEY @"54c9a412fd98c5779c000752"
#define WX_PAY_ID @"wxa8213dc827399101"
#define WX_APP_ID @"wxa8213dc827399101"
#define WX_APP_SECRET @"5c716417ce72ff69d8cf0c43572c9284"

#define SINA_APP_KEY @"3616966952"
#define SINA_APP_SECRET @"fd81f6d31427b467f49226e48a741e28"

#define QQ_APP_ID @"100942993"
#define QQ_APP_KEY @"8edd3cc7ca8dcc15082d6fe75969601b"

#define OSC_BANNER_HEIGHT 223

#define TRADERBANNER_URL @"http://code.taobao.org/svn/ytapis/adverise.html"

/************************************接口***************************************************/

#define TRADER_PRICE_URL   @"http://m.sojex.cn/api.do?rtp=batchQuote&ids=[12,13,22,14]"
#define NEWS_REALTIME_URL  @"http://m.sojex.cn/api.do?&rtp=RealTime&page=1"

/************************************通知***************************************************/

#define TRADER_DATA_UPDATE @"TRADER_DATA_UPDATE"
#define NEWS_DATA_UPDATE @"NEWS_DATA_UPDATE"

/*************************极光推送*********************************/

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

static NSString *CXAPI_JIPUSH_KEY = @"fefad41c2457f3486c430f2a";
static NSString *CXAPI_JIPUSH_CHANNEL = @"App Store";
#define CXAPI_USER_NOTICE      @"CXAPI_USER_NOTICE"

#endif /* AppConfig_h */
