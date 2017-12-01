//
//  NewsInfo.h
//  TraderApp
//
//  Created by tao song on 17/4/28.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONTools.h"

@interface NewsInfo : NSObject <NSCoding>

@property (nonatomic,copy) NSString *nId;

@property (nonatomic,copy) NSString *imageUrl;

@property (nonatomic,copy) NSString *time;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *ntype;

@property (nonatomic,copy) NSString  *npage;


- (instancetype)initWithObjectFormDict:(NSDictionary *)dict;

@end
