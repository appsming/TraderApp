//
//  UIBarButtonItem+Collection.h
//  TraderApp
//
//  Created by tao song on 17/5/5.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Collection)

/**
 *  快速创建一个item对象(包装一个button)
 *
 *  @param image   按钮图片
 *  @param hilight 高亮图
 *  @param target  按钮的监听器
 *  @param action  按钮的件提起的回调方法
 *
 *  @return 创建的item对象
 */
+(UIBarButtonItem *)itemWithImage:(NSString *)image higlightedImage:(NSString *)hilight target:(id)target action:(SEL)action;

@end
