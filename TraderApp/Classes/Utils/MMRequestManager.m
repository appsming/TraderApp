//
//  MMRequestManager.m
//
//  Created by 834266718 on 15/9/29.
//  Copyright (c) 2015年 834266718. All rights reserved.
//

#import "MMRequestManager.h"

@implementation MMRequestManager
- (void)startRequestDeletate:(id)delegate urlString:(NSString *)urlStr parameters:(NSDictionary *)parameters andHttpType:(HttpRequestType)type {
    self.delegate = delegate;
    
    //添加弱引用，避免内存泄漏
    __weak typeof(self) wself = self;
    AFHTTPRequestOperationManager  *manager  = [AFHTTPRequestOperationManager WXManager];
    
    
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString *jsonString = [[NSString alloc] initWithData:responseObject
                                                     encoding:NSUTF8StringEncoding];
        
        
        
        
        NSDictionary *dictJson =  [JSONTools parseJsonFromStringOrObject:jsonString];
        
        
        
        if (type == HttpRequestTypeCommon) {
            if (wself.delegate && [wself.delegate respondsToSelector:@selector(didGetCommonSuccess:infoDic:andManagerTag:)]) {
                [wself.delegate didGetCommonSuccess:self infoDic:dictJson andManagerTag:wself.tag];
            }
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        if (type == HttpRequestTypeCommon) {
            if (wself.delegate && [wself.delegate respondsToSelector:@selector(didGetCommonFail:errorStr: andManagerTag:)]) {
                
                [wself.delegate didGetCommonFail:self errorStr:@"请求失败，请重试" andManagerTag:wself.tag];
            }
        }
        
    }];
    
    
    
}



- (void)dealloc {
    _delegate = nil;
}

@end




