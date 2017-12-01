//
//  FeedBackViewController.m
//  JiangYinGongJiao
//
//  Created by 834266718 on 16/6/29.
//  Copyright © 2016年 834266718. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController () <UITextViewDelegate>

@end

@implementation FeedBackViewController {
    UIScrollView  *_scrollView;
    UITextField   *_nameTextField;
    UITextField   *_teleTextField;
    UITextView    *_textView;
    UILabel       *_alertLabel;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    for (UIView *view in _inputViews) {
        [view resignFirstResponder];
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(NaviHeight, 0, 0, 0);
    [self.view addSubview:_scrollView];
    float start_y = NaviHeight + 10;
    
    [self creatMyLabel:@"姓名" frame:CGRectMake(20, start_y, 80, 46) afloat:16 aview:_scrollView withColorStr:@"777777"];
    
    start_y += 46;
    
    UIView *bgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, start_y, ScreenWidth, 46)];
    bgView1.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bgView1];
    
    for (int i = 0; i < 2; i ++) {
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, start_y + i * 46, ScreenWidth, LINE_HEIGHT)];
        line1.backgroundColor = LINE_COLOR;
        [_scrollView addSubview:line1];
    }
    
    _nameTextField = [self creatTextField:CGRectMake(20, start_y, ScreenWidth - 30, 46) aview:_scrollView afloat:16];
    _nameTextField.textColor = [UIColor colorFromHexRGB:@"333333"];
    _nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    _nameTextField.returnKeyType = UIReturnKeyDone;
    _nameTextField.placeholder = @"请输入姓名";
    
    start_y += 46;
    
    [self creatMyLabel:@"电话" frame:CGRectMake(20, start_y, 80, 46) afloat:16 aview:_scrollView withColorStr:@"777777"];
    
    start_y += 46;
    
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, start_y, ScreenWidth, 46)];
    bgView2.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bgView2];
    
    for (int i = 0; i < 2; i ++) {
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, start_y + i * 46, ScreenWidth, LINE_HEIGHT)];
        line1.backgroundColor = LINE_COLOR;
        [_scrollView addSubview:line1];
    }
    
    _teleTextField = [self creatTextField:CGRectMake(20, start_y, ScreenWidth - 30, 46) aview:_scrollView afloat:16];
    _teleTextField.textColor = [UIColor colorFromHexRGB:@"333333"];
    _teleTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _teleTextField.clearButtonMode = UITextFieldViewModeAlways;
    _teleTextField.returnKeyType = UIReturnKeyDone;
    _teleTextField.placeholder = @"请输入电话";
    
    start_y += 46;
    
    [self creatMyLabel:@"留言内容" frame:CGRectMake(20, start_y, 120, 46) afloat:16 aview:_scrollView withColorStr:@"777777"];
    
    start_y += 46;
    
    UIView *bgView3 = [[UIView alloc] initWithFrame:CGRectMake(0, start_y, ScreenWidth, 132)];
    bgView3.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bgView3];
    
    for (int i = 0; i < 2; i ++) {
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, start_y + i * 132, ScreenWidth, LINE_HEIGHT)];
        line1.backgroundColor = LINE_COLOR;
        [_scrollView addSubview:line1];
    }
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(14, start_y + 6, ScreenWidth - 28, 120)];
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.textColor = [UIColor colorWithWhite:0 alpha:0.85];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    [_scrollView addSubview:_textView];
    
    _alertLabel = [self creatMyLabel:@"请填写留言内容" frame:CGRectMake(20, start_y + 12, 250, 20) afloat:15 aview:_scrollView withColorStr:@"cccccc"];
    
    start_y += 132 + 10;
    
    UIButton *subBtn = [self creatGreenBtn:CGRectMake(20, start_y, ScreenWidth - 40, 44) title:@"提交" onView:_scrollView tag:1];
    subBtn.backgroundColor = [UIColor colorFromHexRGB:XIAN_BLUE];
    subBtn.clipsToBounds = YES;
    subBtn.layer.cornerRadius = 22;
    
    start_y += 62;
    
    _scrollView.contentSize = CGSizeMake(ScreenWidth, start_y);
    _inputViews = [[NSMutableArray alloc] initWithObjects:_nameTextField, _teleTextField, _textView, nil];
    
}
- (void)btnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 1:
        {//提交
            if (![_nameTextField.text have]) {
                [self showMBP:@"姓名不能为空"];
                return;
            }
            if (![_teleTextField.text have]) {
                [self showMBP:@"电话不能为空"];
                return;
            }
            
            if (![TDevice validateNumber:_teleTextField.text]) {
                [self showMBP:@"电话不合格"];
                return;
            }
            
            
            if (![_textView.text have]) {
                [self showMBP:@"留言不能为空"];
                return;
            }
           
            
            if (![TDevice isNetworkExist]) {
                [self showMBP:NO_WAN_CONNECT];
                return;
            }
            [self showMBPwaiting:nil];
            
            NSString *urlStr = @"https://www.apple.com/";
            MMRequestManager *manager = [[MMRequestManager alloc] init];
            [_requestArray addObject:manager];
            [manager startRequestDeletate:self urlString:urlStr parameters:nil andHttpType:HttpRequestTypeCommon];
            
        }
            break;
            
        default:
            break;
    }
}





- (void)didGetCommonSuccess:(MMRequestManager *)manager infoDic:(NSDictionary *)dic andManagerTag:(NSInteger)tag
{
    [self showMBP:@"提交成功"];
    _nameTextField.text = @"";
    _teleTextField.text = @"";
    _textView.text = @"";
    _alertLabel.hidden = NO;
    if ([_requestArray containsObject:manager]) {
        [_requestArray removeObject:manager];
    }


}


- (void)didGetCommonFail:(MMRequestManager *)manager errorStr:(NSString *)errorStr andManagerTag:(NSInteger)tag
{
    [self showFailMBP:errorStr];
    if ([_requestArray containsObject:manager]) {
        [_requestArray removeObject:manager];
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (range.length < [text length] && range.location >= 300) {
        [self creatAlertView:@"字符个数不能大于300"];
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text have]) {
        _alertLabel.hidden = YES;
    } else {
        _alertLabel.hidden = NO;
    }
}
#pragma mark - UIKeyboardNotification
- (void)keyboardWillShow:(NSNotification *)noti {
    NSString *durStr = [NSString stringWithFormat:@"%@",[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]];
    float duration = durStr.floatValue;
    if (duration < 0.1) {
        duration = 0.1;
    }
    CGSize size = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, size.height, 0);
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(NaviHeight, 0, size.height, 0);
    
    for (UIView *view in _inputViews) {
        if ([view isFirstResponder]) {
            if (view.frame.origin.y + view.frame.size.height - _scrollView.contentOffset.y > ScreenHeight - size.height - 10) {
                [UIView animateWithDuration:duration animations:^{
                    _scrollView.contentOffset = CGPointMake(0, view.frame.origin.y + view.frame.size.height + size.height + 10 - ScreenHeight);
                }];
            }
        }
    }
}
- (void)keyboardWillHidden {
    [UIView animateWithDuration:0.25 animations:^{
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(NaviHeight, 0, 0, 0);
    }];
}



@end
