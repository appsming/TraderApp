//
//  BaseResponse.h
//  TraderApp
//
//  Created by tao song on 17/4/28.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONTools.h"

@interface BaseResponse : NSObject

@property (nonatomic,assign) NSInteger status;

@property (nonatomic,copy) NSString *desc;

@property (nonatomic,copy) NSDictionary *data;

@property (nonatomic,assign) Boolean  hasNext;

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict;


@end
