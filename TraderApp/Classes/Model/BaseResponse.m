//
//  BaseResponse.m
//  TraderApp
//
//  Created by tao song on 17/4/28.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "BaseResponse.h"

static NSString * const kData= @"data";

static NSString * const kDesc= @"desc";

static NSString * const kStatus= @"status";

static NSString * const kHasNext= @"has";


@implementation BaseResponse

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict
{
    self = [super init];
    if (!self) {return nil;}
    
    
    _data  =[dict  objectForKey:kData];
    

    _desc = [dict objectForKey:kDesc];
    
    _status = [[dict objectForKey:kStatus] integerValue];
 
    _hasNext  = [[dict objectForKey:kHasNext] boolValue];
    
    return self;
}
@end
