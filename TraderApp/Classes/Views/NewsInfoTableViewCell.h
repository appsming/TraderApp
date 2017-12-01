//
//  NewsInfoTableViewCell.h
//  TraderApp
//
//  Created by tao song on 17/5/2.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UsualTableViewCell.h"
#import "NewsInfo.h"

@interface NewsInfoTableViewCell : UsualTableViewCell


+(instancetype)returnReuseCellFormTableView:(UITableView* )tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@property (nonatomic, strong) NewsInfo* viewModel; //线下活动model

@end
