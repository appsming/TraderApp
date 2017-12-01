//
//  NewsDetailInfo.m
//  TraderApp
//
//  Created by tao song on 17/5/5.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "NewsDetailInfo.h"

static NSString * const kNCreatetime= @"createtime";

static NSString * const kContent= @"content";

static NSString * const kTitle= @"title";

static NSString * const kPicture= @"picture";

static NSString * const kMedia= @"media";

static NSString * const kUrl= @"url";

@implementation NewsDetailInfo

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict
{

    
    self = [super init];
    if (!self) {return nil;}
    
    _ncreatetime = [dict objectForKey:kNCreatetime];

    _ncontent = [dict objectForKey:kContent];

    _ntitle = [dict objectForKey:kTitle];
    
    _npicture = [dict objectForKey:kPicture];
    
    _nmedia = [dict objectForKey:kMedia];
    
    _nurl = [dict objectForKey:kUrl];
    
    return self;

}


@end
