//
//  ProductView.m
//  TraderApp
//
//  Created by tao song on 17/5/4.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "ProductView.h"
#import "TDevice.h"

@implementation ProductView

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
    
    _pdescLabel = [[UILabel alloc]  init];
    
    _traderLabel = [[UILabel alloc]  init];
    
    
    [_pnameLabel setFont:[UIFont systemFontOfSize:13.0f]];
    
    [_pdescLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0f]];
    
    
    [_traderLabel setFont:[UIFont systemFontOfSize:13.0f]];
    
    [_pnameLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_pdescLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_traderLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self addSubview:_pnameLabel];
    
    [self addSubview:_pdescLabel];
    
    [self addSubview:_traderLabel];
    
    
}

- (void)layoutUI
{
    
    [_pnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
       make.top.mas_equalTo(self.mas_top).offset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(@20);
    }];
    
    
    [_pdescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pnameLabel.mas_bottom).offset(5);
        make.bottom.mas_equalTo(_traderLabel.mas_top).offset(-5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(_pnameLabel.mas_width);
        make.height.mas_equalTo(_pnameLabel.mas_height);
    }];
    
    [_traderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pdescLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(_pdescLabel.mas_width);
        make.height.mas_equalTo(_pdescLabel.mas_height);
    }];
    
    

}


- (void)setProductInfo:(ProductInfo *)productInfo
{

    _productInfo = productInfo;
    
    
   
}

@end
