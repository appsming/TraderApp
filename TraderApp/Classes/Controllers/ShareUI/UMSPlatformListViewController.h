//
//  UMSAuthViewController.h
//  UMSocialSDK
//
//  Created by wyq.Cloudayc on 11/8/16.
//  Copyright © 2016 UMeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSBaseViewController.h"

typedef NS_ENUM(NSUInteger, UMSAuthViewType)
{

    UMSAuthViewTypeShare
};
@interface UMSPlatformListViewController : UMSBaseViewController

- (instancetype)initWithViewType:(UMSAuthViewType)type;

@end
