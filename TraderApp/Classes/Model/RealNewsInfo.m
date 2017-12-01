//
//  RealNewsInfo.m
//  TraderApp
//
//  Created by tao song on 17/4/28.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "RealNewsInfo.h"

static NSString * const kRNId= @"id";

static NSString * const kRIcon= @"icon";

static NSString * const kContext= @"context";

static NSString * const kRTime= @"time";

static NSString * const kRColor= @"color";

static NSString * const kRForm= @"form";

static NSString * const kRType= @"type";

@implementation RealNewsInfo

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict
{

   self =  [super init];

    if (self) {
        
        _rcolors = [dict  objectForKey:kRColor];
        
        _rnid = [dict objectForKey:kRNId];
        
        _ricon = [dict objectForKey:_ricon];
    
        _rntime = [dict objectForKey:kRTime];
        
        _rntype = [dict objectForKey:kRType];
        
        _rformat = [dict objectForKey:kRForm];
    
        _rcontent = [dict objectForKey:kContext];
    }
    
    return self;
}

@end
