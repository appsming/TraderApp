//
//  BaseViewController.h
//  TraderApp
//
//  Created by tao song on 17/4/24.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDevice.h"
#import "MMRequestManager.h"
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController  <UITextFieldDelegate, MMRequestManagerDelegate, UIAlertViewDelegate> 
{

    //存放输入框
    NSMutableArray *_inputViews;
    //用来存放请求
    NSMutableArray *_requestArray;
}




- (UILabel *)creatMyLabel:(NSString *)text frame:(CGRect)frame afloat:(CGFloat)afloat aview:(UIView *)aview withColorStr:(NSString *)colorStr;
- (UIButton *)creatBtnWithImage:(NSString *)imgStr frame:(CGRect)frame aview:(UIView *)aview tag:(int)tag;
- (UIButton *)creatMyBtn:(CGRect)frame aview:(UIView *)aview tag:(int)tag;
- (UIButton *)creatGreenBtn:(CGRect)frame title:(NSString *)title onView:(UIView *)aview tag:(int)tag;

- (UIImageView *)creatImgView:(CGRect)frame aview:(UIView *)aview imgStr:(NSString *)imgStr;
- (UIImageView *)creatCenterImageView:(CGRect)frame onView:(UIView *)aview imgStr:(NSString *)imgStr;
- (UITextField *)creatTextField:(CGRect)frame aview:(UIView *)aview afloat:(CGFloat)afloat;

- (BOOL)isPhoneNumber:(NSString *)num;
- (void)showMBPwaiting:(NSString *)msg;
- (void)hideMBPwaiting;
- (void)showMBP:(NSString *)msg;
- (void)showFailMBP:(NSString *)msg;

- (void)btnClick:(UIButton *)btn;
- (void)creatAlertView:(NSString *)msg;

@end
