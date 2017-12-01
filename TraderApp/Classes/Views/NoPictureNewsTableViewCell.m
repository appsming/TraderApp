//
//  NoPictureNewsTableViewCell.m
//  TTNews
//
//  Created by 瑞文戴尔 on 16/4/14.
//  Copyright © 2016年 瑞文戴尔. All rights reserved.
//

#import "NoPictureNewsTableViewCell.h"
#import "UILabel+HeightUtils.h"
@interface NoPictureNewsTableViewCell()



@end

@implementation NoPictureNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.commentCountLabel.text = @"";
    self.separatorLine.hidden = YES;
   // self.selectionStyle = UITableViewCellSelectionStyleNone;
   }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (void)setRealNewsInfo:(RealNewsInfo *)realNewsInfo
{

    _realNewsInfo = realNewsInfo;
    
  
    
    
    NSString * timeStampString =realNewsInfo.rntime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss "];
    NSString *currentDateStr =  [objDateformat stringFromDate: date];

    if ([realNewsInfo.rcolors isEqualToString:@"红色"]) {
        [self.contentLabel setTextColor:[UIColor redColor]];
        [self.newsTitleLabel setTextColor:[UIColor redColor]];
    }
    
    [self.contentLabel  setFont:[UIFont systemFontOfSize:16.0f]];

   
 
    UILabel *label = self.contentLabel;
    
    CGSize size = [realNewsInfo.rcontent sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, label.frame.size.height)];
    
    [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, size.width, label.frame.size.height)];
  
    
    self.newsTitleLabel.text = currentDateStr;
    self.contentLabel.text  = realNewsInfo.rcontent;
}

@end
