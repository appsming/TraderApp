//
//  NewsCollectionController.m
//  TraderApp
//
//  Created by tao song on 17/5/5.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "NewsCollectionController.h"
#import "TDevice.h"
#import "NewsDetailViewController.h"
@interface NewsCollectionController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *collectionTableView;
@property (nonatomic,strong) NSMutableArray *collectionAry;

@end

@implementation NewsCollectionController

- (instancetype)init
{

    self  = [super init];

    if (self) {
        
        _collectionAry = [[NSMutableArray alloc] init];
    }
    return self;

}

- (void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    [self reflushData];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
   // [self initCollectionData];
    [self initCollectionView];
}


- (void)initCollectionData
{

  NSMutableArray *newsAry =    [TDevice newsCollectionList];

   self.collectionAry =  [newsAry mutableCopy];

}



- (void)initCollectionView
{

    _collectionTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_collectionTableView];
    _collectionTableView.delegate = self;
    _collectionTableView.dataSource = self;
    

}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.collectionAry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
     NewsInfo  *info = self.collectionAry[indexPath.row];
  
    cell.textLabel.text = info.title;
    
    cell.detailTextLabel.text = info.time;
    
    return  cell;



}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NewsInfo *info = [self.collectionAry objectAtIndex:indexPath.row];
    CGSize size = [info.time mm_sizeWithFont:15 withWidth:ScreenWidth - 65];
    size.height += 29;
    return size.height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewsInfo  *newsInfo = self.collectionAry[indexPath.row];

    NewsDetailViewController  *newsDetailVC  = [[NewsDetailViewController alloc] init];
    newsDetailVC.title = @"资讯详情";
//    newsInfo.ntype  = ntypeId;
//    newsInfo.npage = @"1";
    newsDetailVC.newsInfo = newsInfo;
    
    newsDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newsDetailVC animated:YES];



}


- (void)reflushData
{

    [self initCollectionData];

    if (self.collectionTableView) {
        [self.collectionTableView reloadData];
    };


}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
