//
//  ProductView.h
//  TraderApp
//
//  Created by tao song on 17/5/4.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProductInfo.h"

@interface ProductView : UIView

@property (nonatomic,strong) ProductInfo *productInfo;

@property (nonatomic,strong) UILabel *pnameLabel;

@property (nonatomic,strong)  UILabel *pdescLabel;

@property (nonatomic,strong) UILabel *traderLabel;



@end
