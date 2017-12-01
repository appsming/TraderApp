//
//  TDevice.m
//  TraderApp
//
//  Created by tao song on 17/4/22.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "TDevice.h"

@implementation TDevice


+ (MBProgressHUD *)createHUD
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    HUD.detailsLabel.font = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    [HUD showAnimated:YES];
    HUD.removeFromSuperViewOnHide = YES;
    //[HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
    
    return HUD;
}

+ (NSInteger)networkStatus
{
    return [AFNetworkReachabilityManager shareReachability].networkReachabilityStatus;
}

+ (BOOL)isNetworkExist
{
    return [self networkStatus] != 0;
}

+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}



+ (NSArray *)parseDictWithAry:(NSDictionary *)data
{
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    
    for (NSDictionary *dict in data) {
        [array addObject:dict];
    }
    return array;
    
}





+ (NSMutableArray *)getBannerData{
    
    NSMutableArray  *imageArr = [[NSMutableArray alloc] init];
    
    
    NSString *jsonString = @"{ \"status\":\"1000\", \"desc\":\"success\", \"data\": [ { \"name\": \"test\", \"detail\": \"test\", \"img\": \"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg\", \"href\": \"https://www.baidu.com\", \"id\": 0, \"time\": \"2017-05-02\" }, { \"name\": \"test2\", \"detail\": \"test2\", \"img\": \"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg\", \"href\": \"https://www.baidu.com\", \"id\": 2, \"time\": \"2017-05-02\" }, { \"name\": \"test3\", \"detail\": \"test3\", \"img\": \"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg\", \"href\": \"https://www.baidu.com\", \"id\": 0, \"time\": \"2017-05-02\" } ], \"has\":\"false\" }";
    
    
    
    
    NSDictionary *dictJson =  [JSONTools parseJsonFromStringOrObject:jsonString];
    
    
    BaseResponse  *baseResponse = [[BaseResponse alloc] initWithObjectFormDict:dictJson];
    
    
    
    
    if (baseResponse.status == 1000) {
        
        
        NSArray  *mydataAry  = [TDevice parseDictWithAry:baseResponse.data];
        
        
        for (NSDictionary  *mdict  in mydataAry) {
            BOOL shouldBeAdded = YES;
            TraderBannerInfo  *carInfo = [[TraderBannerInfo alloc] initWithObjectFormDict:mdict];
            
            for (TraderBannerInfo *tempCars in imageArr) {
                if ([carInfo isEqual:tempCars]) {
                    shouldBeAdded = NO;
                    break;
                }
                
            }
            
            if (shouldBeAdded) {
                [imageArr addObject:carInfo];
                
            }
            
            
        }
        
    }
    
    return imageArr;
}


+ (NSDictionary *)settingAttributesWithLineSpacing:(CGFloat)lineSpacing FirstLineHeadIndent:(CGFloat)firstLineHeadIndent Font:(UIFont *)font TextColor:(UIColor *)textColor{
    //分段样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraphStyle.lineSpacing = lineSpacing;
    //首行缩进
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    //富文本样式
    NSDictionary *attributeDic = @{
                                   NSFontAttributeName : font,
                                   NSParagraphStyleAttributeName : paragraphStyle,
                                   NSForegroundColorAttributeName : textColor
                                   };
    return attributeDic;
}




+ (void)saveNewsCollectionWith:(NewsInfo *)newsInfo
{

    NSMutableArray   *tempAry = [self newsCollectionList];
    
 NSMutableArray  *otherAry =    [[NSMutableArray alloc] init];
    
    
    if (tempAry.count >0 ) {
        
        Boolean isShouldAdd = YES;
        
        for (int i = 0 ; i < tempAry.count;i++) {
            
             NewsInfo *f=   tempAry [i];
            
            if ([f.nId isEqualToString:newsInfo.nId]) {
               
                isShouldAdd = NO;
                 [tempAry removeObject:f];
                break;
                
            }
            
            if (isShouldAdd) {
                [otherAry addObject:newsInfo];
            }
        }
    }else {

        [otherAry addObject:newsInfo];
   
  }

    [tempAry addObjectsFromArray:otherAry];


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

   NSData *encodedSingleObj = [NSKeyedArchiver archivedDataWithRootObject:tempAry];
    
   [defaults setObject:encodedSingleObj forKey:@"newsCollectionList"];
    [defaults synchronize];
}


+ (NSMutableArray *)newsCollectionList
{
    
    NSMutableArray *sightingList = [[NSMutableArray alloc] init];
  
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *prevSavedData = [defaults objectForKey:@"newsCollectionList"];
    NSMutableArray *collectionAry  = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:prevSavedData];
    if(collectionAry != nil)
    {
        sightingList = [collectionAry mutableCopy];
    }
    
    return  sightingList;
}


+ (Boolean)isExitObj:(NewsInfo *)newsInfo
{
    
    Boolean  isExist = NO;
    
    
    NSMutableArray  *tempAr   = [self newsCollectionList];
    
   
    if (tempAr.count > 0 ) {
        
        
        for (NewsInfo *f in tempAr) {
    
            
            if ([f.nId isEqualToString:newsInfo.nId]) {
                
                isExist  = YES;
                break;
            }
            
            
        }
    }
    
    return isExist;
    
}


#pragma marker -- 提示信息
+ (void)showMesssageDialog:(NSString *)msg andAlertTag:(NSInteger)tag
{
    
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alter.tag = tag;
    [alter show];
}
@end
