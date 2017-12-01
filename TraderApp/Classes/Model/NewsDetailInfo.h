//
//  NewsDetailInfo.h
//  TraderApp
//
//  Created by tao song on 17/5/5.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailInfo : NSObject

@property (nonatomic,copy) NSString *ncreatetime;

@property (nonatomic,copy) NSString *ncontent;

@property (nonatomic,copy) NSString *npicture;

@property (nonatomic,copy) NSString *ntitle;

@property (nonatomic,copy) NSString *nmedia;

@property (nonatomic,copy) NSString *nurl;

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict;

@end
