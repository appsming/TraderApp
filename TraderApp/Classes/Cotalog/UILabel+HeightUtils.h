//
//  UILabel+HeightUtils.h
//  TraderApp
//
//  Created by tao song on 17/5/6.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HeightUtils)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

@end
