//
//  RealNewsInfo.h
//  TraderApp
//
//  Created by tao song on 17/4/28.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONTools.h"
@interface RealNewsInfo : NSObject

@property (nonatomic,copy) NSString *rntype;

@property (nonatomic,copy) NSString *rcontent;

@property (nonatomic,copy) NSString *rntime;

@property (nonatomic,copy) NSString *rformat;

@property (nonatomic,copy) NSString *rnid;

@property (nonatomic,copy) NSString *ricon;

@property (nonatomic,copy) NSString *rcolors;

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict;

@end
