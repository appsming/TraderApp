//
//  AboutMeController.h
//  TraderApp
//
//  Created by tao song on 17/4/24.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface AboutMeController : UIViewController <UIWebViewDelegate, NJKWebViewProgressDelegate>

@property (nonatomic,copy) NSString *webUrl;

@end
