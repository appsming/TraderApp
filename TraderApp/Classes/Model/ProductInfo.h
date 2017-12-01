//
//  ProductInfo.h
//  TraderApp
//
//  Created by tao song on 17/5/4.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductInfo : NSObject

@property (nonatomic,assign) NSInteger productType;

@property (nonatomic,copy) NSString *pmp;

@property (nonatomic,copy) NSString *ptime;

@property (nonatomic,assign) long   updatetime;

@property (nonatomic,assign) float buy;

@property (nonatomic,assign) float last_close;

@property (nonatomic,copy) NSString *code;

@property (nonatomic,copy) NSString *pid;

@property (nonatomic,copy) NSString *color;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,assign) float  open;

@property (nonatomic,assign) float sell;

@property (nonatomic,assign) float margin;

@property (nonatomic,assign) NSInteger falg;

@property (nonatomic,assign) float low;

@property (nonatomic,assign) float top;

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict;


@end
