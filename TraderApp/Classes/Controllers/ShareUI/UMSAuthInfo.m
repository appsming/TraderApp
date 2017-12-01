//
//  UMSAuthInfo.m
//  TraderApp
//
//  Created by tao song on 17/4/25.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "UMSAuthInfo.h"



@implementation UMSAuthInfo

+ (instancetype)objectWithType:(UMSocialPlatformType)platform
{
    UMSAuthInfo *obj = [UMSAuthInfo new];
    obj.platform = platform;
    UMSocialUserInfoResponse *resp = nil;
    
    NSDictionary *authDic = [[UMSocialDataManager defaultManager ] getAuthorUserInfoWithPlatform:platform];
    if (authDic) {
        resp = [[UMSocialUserInfoResponse alloc] init];
        resp.uid = [authDic objectForKey:kUMSocialAuthUID];
        resp.accessToken = [authDic objectForKey:kUMSocialAuthAccessToken];
        resp.expiration = [authDic objectForKey:kUMSocialAuthExpireDate];
        resp.refreshToken = [authDic objectForKey:kUMSocialAuthRefreshToken];
        resp.openid = [authDic objectForKey:kUMSocialAuthOpenID];
        
        obj.response = resp;
    }
    return obj;
}

@end

