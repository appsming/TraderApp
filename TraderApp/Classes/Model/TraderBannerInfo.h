//
//  TraderBannerInfo.h
//  TraderApp
//
//  Created by tao song on 17/5/2.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TraderBannerInfo : NSObject


@property (nonatomic,strong) NSString* name;

@property (nonatomic,strong) NSString* detail;

@property (nonatomic,strong) NSString* img;

@property (nonatomic,strong) NSString* href;

@property (nonatomic,assign) NSInteger id;

@property (nonatomic,strong) NSString* time;

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict;


@end
