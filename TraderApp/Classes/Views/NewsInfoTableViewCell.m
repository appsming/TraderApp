//
//  NewsInfoTableViewCell.m
//  TraderApp
//
//  Created by tao song on 17/5/2.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "NewsInfoTableViewCell.h"

@implementation NewsInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - public method
+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString
{
    NewsInfoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifierString
                                                                     forIndexPath:indexPath];
    
    
    return cell;
    
}

@end
