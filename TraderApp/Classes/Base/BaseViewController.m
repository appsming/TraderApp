//
//  BaseViewController.m
//  TraderApp
//
//  Created by tao song on 17/4/24.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"f1f2f3"];
    _requestArray = [[NSMutableArray alloc] initWithCapacity:0];
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    firstView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:firstView];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for (int i = (int)_requestArray.count - 1; i >= 0; i --) {
        MMRequestManager *manager = [_requestArray objectAtIndex:i];
        if ([manager isKindOfClass:[MMRequestManager class]]) {
            manager.delegate = nil;
            [_requestArray removeObject:manager];
        }
    }
}




- (UILabel *)creatMyLabel:(NSString *)text frame:(CGRect)frame afloat:(CGFloat)afloat aview:(UIView *)aview  withColorStr:(NSString *)colorStr {
    UILabel *myLabel = [[UILabel alloc] initWithFrame:frame];
    myLabel.text = text;
    myLabel.backgroundColor = [UIColor clearColor];
    if (colorStr) {
        myLabel.textColor = [UIColor colorFromHexRGB:colorStr];
    } else {
        myLabel.textColor = [UIColor colorWithWhite:0 alpha:0.85];
    }
    myLabel.font = [UIFont systemFontOfSize:afloat];
    if (aview) {
        [aview addSubview:myLabel];
    }
    return  myLabel;
}

- (UIButton *)creatBtnWithImage:(NSString *)imgStr frame:(CGRect)frame aview:(UIView *)aview tag:(int)tag {
    
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = frame;
    [headerBtn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    if ([imgStr hasSuffix:@"_n"]) {
        NSString *highlightedImgStr = [imgStr stringByReplacingCharactersInRange:NSMakeRange(imgStr.length - 2, 2) withString:@"_h"];
        UIImage *hImage = [UIImage imageNamed:highlightedImgStr];
        if (hImage) {
            [headerBtn setImage:hImage forState:UIControlStateHighlighted];
        }
    }
    
    [headerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    headerBtn.tag = tag;
    [aview addSubview:headerBtn];
    return headerBtn;
}

- (UIButton *)creatMyBtn:(CGRect)frame aview:(UIView *)aview tag:(int)tag {
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = frame;
    [headerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    headerBtn.tag = tag;
    if (aview) {
        [aview addSubview:headerBtn];
    }
    return headerBtn;
}
- (UIButton *)creatGreenBtn:(CGRect)frame title:(NSString *)title onView:(UIView *)aview tag:(int)tag {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setBackgroundImage:[[UIImage imageNamed:@"rect_red_btn"] stretchableImageWithLeftCapWidth:12 topCapHeight:12] forState:UIControlStateNormal];
    [aview addSubview:btn];
    return btn;
}
- (UIImageView *)creatImgView:(CGRect)frame aview:(UIView *)aview imgStr:(NSString *)imgStr {
    UIImageView *userImg = [[UIImageView alloc] initWithFrame:frame];
    userImg.image = [UIImage imageNamed:imgStr];
    [aview addSubview:userImg];
    return userImg;
}
- (UIImageView *)creatCenterImageView:(CGRect)frame onView:(UIView *)aview imgStr:(NSString *)imgStr {
    UIImageView *userImg = [[UIImageView alloc] initWithFrame:frame];
    UIImage *image = [UIImage imageNamed:imgStr];
    userImg.image = image;
    if (image.size.width <= frame.size.width && image.size.height <= frame.size.height) {
        userImg.contentMode = UIViewContentModeCenter;
    } else {
        userImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    if (aview) {
        [aview addSubview:userImg];
    }
    return userImg;
}
- (UITextField *)creatTextField:(CGRect)frame aview:(UIView *)aview afloat:(CGFloat)afloat {
    
    UITextField *tf = [[UITextField alloc] initWithFrame:frame];
    tf.font = [UIFont  systemFontOfSize:afloat];
    tf.delegate = self;
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if (aview) {
        [aview addSubview:tf];
    }
    return tf;
}
- (BOOL)isPhoneNumber:(NSString *)num {//检测手机号格式；
    long long int a = (long long int)[num longLongValue];
    if (a > 10000000000 && a < 19999999999) {
        return YES;
    } else return NO;
}
- (void)showMBPwaiting:(NSString *)msg {
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = msg;
    [self.view addSubview:hud];
    [hud showAnimated:YES];
}
- (void)hideMBPwaiting {
    [MBProgressHUD hideHUDForView:self.view animated:NO];
}

- (void)showMBP:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    if (![msg have]) {
        return;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeCustomView;
    hud.userInteractionEnabled = NO;
    hud.label.text = msg;
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.2];
}
- (void)showFailMBP:(NSString *)msg {
    [MBProgressHUD hideHUDForView:self.view animated:NO];
   
    if (![msg have]) {
        return;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeCustomView;
    hud.userInteractionEnabled = NO;
    hud.label.text = msg;
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.7];
}

- (void)creatAlertView:(NSString *)msg {
    if (![msg have]) {
        return;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}



- (void)btnClick:(UIButton *)btn {}


@end
