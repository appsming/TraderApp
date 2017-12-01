//
//  AFHTTPRequestOperationManager+Util.m
//  TraderApp
//
//  Created by tao song on 17/4/24.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "AFHTTPRequestOperationManager+Util.h"

@implementation AFHTTPRequestOperationManager (Util)


static AFHTTPRequestOperationManager* _WXManager;
+ (instancetype)WXManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _WXManager = [AFHTTPRequestOperationManager manager];
        
        
        [_WXManager.securityPolicy setAllowInvalidCertificates:YES];  //忽略https证书
        
        [_WXManager.securityPolicy setValidatesDomainName:NO];  //是否验证域名
        // 设置请求格式
        // manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 设置返回格式
        _WXManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
//        _WXManager.responseSerializer.acceptableContentTypes = [_WXManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//        
        
        _WXManager.responseSerializer.acceptableContentTypes = [_WXManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSMutableSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil]];
        
        
        
        [_WXManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    });
    return _WXManager;
}


@end


@implementation AFNetworkReachabilityManager (Comment)

static AFNetworkReachabilityManager* _shareReachability;
+ (AFNetworkReachabilityManager* )shareReachability{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareReachability = [AFNetworkReachabilityManager managerForAddress:@"https://www.apple.com/"];
    });
    return _shareReachability;
}

@end

