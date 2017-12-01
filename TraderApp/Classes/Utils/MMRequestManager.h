//
//  MMRequestManager.h
//
//  Created by 834266718 on 15/9/29.
//  Copyright (c) 2015年 834266718. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager+Util.h"
#import "JSONTools.h"
typedef enum {
    
    HttpRequestTypeCommon,//普通请求
    
    
} HttpRequestType;
@interface MMRequestManager : NSObject
@property (nonatomic, assign) BOOL isCarOnwer;
@property (nonatomic, assign) id  delegate;
@property (nonatomic, assign) int tag;
@property (nonatomic, assign) int index;
@property (nonatomic, copy)   NSString *searchStr;
- (void)startRequestDeletate:(id)delegate urlString:(NSString *)urlStr parameters:(NSDictionary *)parameters andHttpType:(HttpRequestType)type;

@end

@protocol MMRequestManagerDelegate <NSObject>
@optional
//普通请求
- (void)didGetCommonSuccess:(MMRequestManager *)manager infoDic:(NSDictionary *)dic  andManagerTag:(NSInteger) tag;
- (void)didGetCommonFail:(MMRequestManager *)manager errorStr:(NSString *)errorStr andManagerTag:(NSInteger) tag;

@end



