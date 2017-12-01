//
//  UIBarButtonItem+Collection.m
//  TraderApp
//
//  Created by tao song on 17/5/5.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "UIBarButtonItem+Collection.h"

@implementation UIBarButtonItem (Collection)

+(UIBarButtonItem *)itemWithImage:(NSString *)image higlightedImage:(NSString *)hilight target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normal  = [UIImage imageNamed:image];
    [btn setBackgroundImage:normal forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:hilight] forState:UIControlStateHighlighted];
    btn.bounds = CGRectMake(0, 0, normal.size.width, normal.size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
