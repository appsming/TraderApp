//
//  AFHTTPRequestOperationManager+Util.h
//  TraderApp
//
//  Created by tao song on 17/4/24.
//  Copyright © 2017年 tao song. All rights reserved.
//


#import <AFNetworking.h>
#import <AFOnoResponseSerializer.h>
#import <UIKit/UIKit.h>

@interface AFHTTPRequestOperationManager (Util)


+ (instancetype)WXManager;     ///< JSON manger

@end


@interface AFNetworkReachabilityManager (Comment)

+ (AFNetworkReachabilityManager* )shareReachability;

@end
