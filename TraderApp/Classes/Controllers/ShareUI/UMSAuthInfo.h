//
//  UMSAuthInfo.h
//  TraderApp
//
//  Created by tao song on 17/4/25.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

@interface UMSAuthInfo : NSObject

@property (nonatomic, assign) UMSocialPlatformType platform;
@property (nonatomic, strong) UMSocialUserInfoResponse *response;

+ (instancetype)objectWithType:(UMSocialPlatformType)platform;

@end
