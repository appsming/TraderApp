//
//  UIColor+Util.h
//  iosapp
//
//  Created by chenhaoxiang on 14-10-18.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Util)

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hexValue;

/**
 *	@brief	RGB值转换为UIColor对象
 *
 *	@param 	inColorString 	RGB值，如“＃808080”这里只需要传入“808080”
 *
 *	@return	UIColor对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString alpha:(CGFloat)alpha;


+ (UIColor *)themeColor;
+ (UIColor *)nameColor;
+ (UIColor *)titleColor;
+ (UIColor *)separatorColor;
+ (UIColor *)cellsColor;
+ (UIColor *)titleBarColor;
+ (UIColor *)selectTitleBarColor;
+ (UIColor *)navigationbarColor;
+ (UIColor *)selectCellSColor;
+ (UIColor *)labelTextColor;
+ (UIColor *)teamButtonColor;

+ (UIColor *)infosBackViewColor;
+ (UIColor *)lineColor;

+ (UIColor *)contentTextColor;
+ (UIColor *)borderColor;
+ (UIColor *)refreshControlColor;

/* 新版颜色 */
/* 新 cell.contentView 背景色*/
+ (UIColor *)newCellColor;
/* 新“综合”页面cell.titleLable 标题字体颜色*/
+ (UIColor *)newTitleColor;
/* 新section 问答 按钮选中颜色*/
+ (UIColor *)newSectionButtonSelectedColor;
/* 新 分割线*/
+ (UIColor *)newSeparatorColor;
/* 次要文字颜色 */
+ (UIColor *)newSecondTextColor;
/* 辅助文字颜色 */
+ (UIColor *)newAssistTextColor;

@end
