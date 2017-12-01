//
//  NewsInfo.m
//  TraderApp
//
//  Created by tao song on 17/4/28.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "NewsInfo.h"

static NSString * const kNId= @"id";

static NSString * const kImage= @"image";

static NSString * const kTitle= @"title";

static NSString * const kTime= @"time";


@implementation NewsInfo


- (instancetype)initWithObjectFormDict:(NSDictionary *)dict
{
    
    self = [super init];
    if (!self) {return nil;}
    
    
    _nId = [dict objectForKey:kNId];
    
    _imageUrl = [dict objectForKey:kImage];
    
    _time = [dict objectForKey:kTime];
    
    _title = [dict objectForKey:kTitle];
    
    return  self;

}



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.nId = [aDecoder decodeObjectForKey:@"nId"];
        self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
     
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.nId forKey:@"nId"];
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.title forKey:@"title"];
    
}


@end
