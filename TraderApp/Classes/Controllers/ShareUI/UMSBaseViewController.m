//
//  UMSBaeViewController.m
//  UMSocialSDK
//
//  Created by wyq.Cloudayc on 11/22/16.
//  Copyright © 2016 UMeng. All rights reserved.
//

#import "UMSBaseViewController.h"

@interface UMSBaseViewController ()

@end

@implementation UMSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // bar color
 //   UIColor *barColor = [UIColor colorWithRed:0.f/255.f green:134.f/255.f blue:220.f/255.f alpha:1.f];
    
//    UIColor *barColor  = [UIColor navigationbarColor];
//    
//    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
//    if ([[ver objectAtIndex:0] intValue] >= 7) {
//        self.navigationController.navigationBar.barTintColor = barColor;
//        self.navigationController.navigationBar.translucent = NO;
//        
//        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    }else {
//        self.navigationController.navigationBar.tintColor = barColor;
//    }
//
//    // title color
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // background color
    self.view.backgroundColor = [UIColor colorWithRed:.93f green:.93f blue:.956f alpha:1.f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = self.titleString;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.title = @"";
}

//- (CGFloat)viewOffsetY
//{
//    if (self.navigationController.navigationBar.translucent) {
//        CGSize statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
//        return MIN(statusBarSize.width, statusBarSize.height) + self.navigationController.navigationBar.frame.size.height;
//    }
//    return 0.f;
//}
@end
