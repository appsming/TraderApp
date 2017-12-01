//
//  RecommendCaseView.m
//  TraderApp
//
//  Created by tao song on 17/5/5.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "RecommendCaseView.h"
#import "TDevice.h"

@implementation RecommendCaseView



- (instancetype)init {
    self = [super init];
    if (self) {
        [self addProductView];
        [self layoutUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addProductView];
        [self layoutUI];
    }
    
    return self;
    
}

- (void)addProductView
{

    
    
    
    
    
    
    _pnameLabel  = [[UILabel alloc] init];
    
    _pwaysLabel = [[UILabel alloc]  init];
    
    _zhiliLabel = [[UILabel alloc]  init];
    
    _zhichengLabel = [[UILabel alloc]  init];
    
    
    [_pnameLabel setFont:[UIFont systemFontOfSize:12.0f]];

      [_pwaysLabel setFont:[UIFont systemFontOfSize:12.0f]];
    
      [_zhiliLabel setFont:[UIFont systemFontOfSize:12.0f]];
    
      [_zhichengLabel setFont:[UIFont systemFontOfSize:12.0f]];
    
    
    [_pnameLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_pwaysLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_zhiliLabel setTextAlignment:NSTextAlignmentCenter];
    
   [_zhichengLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self addSubview:_pnameLabel];
    
    [self addSubview:_pwaysLabel];
    
    [self addSubview:_zhiliLabel];
    
    [self addSubview:_zhichengLabel];
    



}


- (void)layoutUI
{

    [_pnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(@20);
    }];
    
    
    [_pwaysLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pnameLabel.mas_bottom).offset(5);
        make.bottom.mas_equalTo(_zhiliLabel.mas_top).offset(-5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(_pnameLabel.mas_width);
        make.height.mas_equalTo(_pnameLabel.mas_height);
    }];
    
    [_zhiliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwaysLabel.mas_bottom).offset(5);
        make.bottom.mas_equalTo(_zhichengLabel.mas_top).offset(-5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(_pwaysLabel.mas_width);
        make.height.mas_equalTo(_pwaysLabel.mas_height);
    }];
    
    [_zhichengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_zhiliLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(_zhiliLabel.mas_width);
        make.height.mas_equalTo(_zhiliLabel.mas_height);
    }];
    



}


@end
