//
//  JSONTools.m
//  Monitor
//
//  Created by tao song on 16/7/19.
//  Copyright © 2016年 cxgps. All rights reserved.
//

#import "JSONTools.h"

@implementation JSONTools



+ (NSString *)dictToJsonString:(NSDictionary *)dict
{
    
    NSString *jsonStr = @"数据异常，无法转成JSON";
    
    BOOL isValidJson =   [NSJSONSerialization isValidJSONObject:dict];
    
    if (isValidJson) {
        
        
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        
        jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
    }
    
    
    
    
    return jsonStr;
    
}


// 将JSON转成对象
+ (NSDictionary *)parseJsonFromStringOrObject:(NSString *)data
{
    
    NSData *newData = [data dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSDictionary  * dict = [NSJSONSerialization JSONObjectWithData:newData options:NSJSONReadingAllowFragments error:nil];
    
    
    
    return  dict;
}


@end
