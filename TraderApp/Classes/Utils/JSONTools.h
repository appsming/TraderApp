//
//  JSONTools.h
//  Monitor
//
//  Created by tao song on 16/7/19.
//  Copyright © 2016年 cxgps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONTools : NSObject


+ (NSString *)dictToJsonString:(NSDictionary *)dict;



+ (NSDictionary *)parseJsonFromStringOrObject:(NSString *)data;

@end
