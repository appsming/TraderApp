//
//  TraderBannerInfo.m
//  TraderApp
//
//  Created by tao song on 17/5/2.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "TraderBannerInfo.h"

static NSString * const kBId= @"id";

static NSString * const kBimg= @"img";

static NSString * const kBname= @"name";

static NSString * const kBtime= @"time";

static NSString * const kBdetail= @"detail";

static NSString * const kBurl= @"href";



@interface TraderBannerInfo()

@end



@implementation TraderBannerInfo

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict
{

    
    self =  [super init];
    
    if (self) {

        
        _name  = [dict objectForKey:kBname];
        
        _time = [dict objectForKey:kBtime];
        
        _img = [dict objectForKey:kBimg];
        
        _id = [[dict objectForKey:kBId] integerValue];
        
        
        _detail = [dict objectForKey:kBdetail];
        
        _href = [dict objectForKey:kBurl];
        
        
    }
    
    return self;


}



@end
