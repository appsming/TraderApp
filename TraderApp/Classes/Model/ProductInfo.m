//
//  ProductInfo.m
//  TraderApp
//
//  Created by tao song on 17/5/4.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "ProductInfo.h"

static NSString * const kPmp= @"mp";

static NSString * const kPUpdatetime= @"updatetime";

static NSString * const kPbuy= @"buy";

static NSString * const kPcode= @"code";

static NSString * const kPlastClose= @"last_close";

static NSString * const kPId= @"id";

static NSString * const kPopen= @"open";

static NSString * const kPtime= @"time";

static NSString * const kPcolor= @"color";

static NSString * const kPsell= @"sell";

static NSString * const kPname= @"name";

static NSString * const kPmargin= @"margin";

static NSString * const kPfalg= @"falg";

static NSString * const kPlow= @"low";

static NSString * const kPtop= @"top";



@interface ProductInfo()

@end

@implementation ProductInfo

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict
{

    self =  [super init];
    
    if (self) {
        
        _pmp = [dict objectForKey:kPmp];
        
        _updatetime = [[dict objectForKey:kPUpdatetime] longValue];
        
        _buy = [[dict objectForKey:kPbuy] floatValue];
        
        _code = [dict objectForKey:kPcode];
        
        _last_close = [[dict objectForKey:kPlastClose] floatValue];
        
        _pid  = [dict objectForKey:kPId];
        
        _open = [[dict objectForKey:kPopen] floatValue];
        
        _ptime  = [dict objectForKey:kPtime];
        
        _color = [dict objectForKey:kPcolor];
        
        _sell = [[dict objectForKey:kPsell] floatValue];
        
        _name = [dict objectForKey:kPname];

        _margin  = [[dict objectForKey:kPmargin] floatValue];
        
        _low = [[dict objectForKey:kPlow] floatValue];
        
        _top = [[dict objectForKey:kPtop] floatValue];

    }

    return self;

}

@end
