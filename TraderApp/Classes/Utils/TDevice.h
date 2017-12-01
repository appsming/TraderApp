//
//  TDevice.h
//  TraderApp
//
//  Created by tao song on 17/4/22.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+Util.h"
#import "AppConfig.h"
#import "NSString+Custom.h"
#import "MMRequestManager.h"
#import "JSONTools.h"
#import "AFHTTPRequestOperationManager+Util.h"
#import <Masonry/Masonry.h>
#import <MBProgressHUD.h>
#import "TraderBannerInfo.h"
#import "BaseResponse.h"
#import "UIBarButtonItem+Collection.h"
#import "NewsInfo.h"

@interface TDevice : NSObject

#pragma marker ---提示消息
+ (void)showMesssageDialog:(NSString *)msg andAlertTag:(NSInteger)tag;



+ (Boolean)isExitObj:(NewsInfo *)newsInfo;

+ (NSInteger)networkStatus;
+ (BOOL)isNetworkExist;

+ (BOOL)validateNumber:(NSString*)number;

+  (NSArray *)parseDictWithAry:(NSDictionary *)data;

+ (NSMutableArray *)getBannerData;

+ (NSDictionary *)settingAttributesWithLineSpacing:(CGFloat)lineSpacing FirstLineHeadIndent:(CGFloat)firstLineHeadIndent Font:(UIFont *)font TextColor:(UIColor *)textColor;


+ (MBProgressHUD *)createHUD;

+ (void)saveNewsCollectionWith:(NewsInfo *)newsInfo;

+ (NSMutableArray *)newsCollectionList;



@end
