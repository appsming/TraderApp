//
//  MainTabBarController.m
//  TraderApp
//
//  Created by tao song on 17/4/22.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "MainTabBarController.h"
#import "NoticeNewsController.h"
#import "TraderViewController.h"
#import "NewsViewController.h"
#import "MessageListController.h"
#import "MoreViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    TraderViewController  *traderVC = [[TraderViewController alloc] init];
    
    NewsViewController  *newsVC = [[NewsViewController alloc] init];
    
    MoreViewController  *moreVC = [[MoreViewController alloc] init];
    
    self.tabBar.translucent = NO;
   
    
     NSArray *titles = @[@"行情", @"资讯", @"更多"];
   
    self.viewControllers = @[
                             [self addNavigationItemForViewController:traderVC withTitle:titles[0]],
                             [self addNavigationItemForViewController:newsVC withTitle:titles[1]],
                             [self addNavigationItemForViewController:moreVC withTitle:titles[2]],
                             ];
    
    
    NSArray *images = @[@"tabbar-home",@"tabbar-news", @"tabbar-me"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        item.image = [[UIImage imageNamed:images[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:[images[idx] stringByAppendingString:@"-selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];
    

}




#pragma mark -

- (UINavigationController *)addNavigationItemForViewController:(UIViewController *)viewController withTitle:(NSString *)title
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
 
    [viewController setTitle:title];
    
    
    UIBarButtonItem  *messageButtonItem =  [[UIBarButtonItem alloc] initWithImage:[UIImage  imageNamed:@"ic_email"]   style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(showMessageController)];
    
    UIBarButtonItem  *noticeButtonItem =  [[UIBarButtonItem alloc] initWithImage:[UIImage  imageNamed:@"ic_notice"]   style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(showNoticeController)];
    
    
    
    viewController.navigationItem.leftBarButtonItem = messageButtonItem;
    viewController.navigationItem.rightBarButtonItem =noticeButtonItem;
    
    
    return navigationController;
}


#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (self.selectedIndex == 0 && self.selectedIndex == [tabBar.items indexOfObject:item]) {
        TraderViewController *traderIndexVC = (TraderViewController *)((UINavigationController *)self.selectedViewController).viewControllers[0];
        [traderIndexVC refreshCurrentViewController];
    }
    
    if (self.selectedIndex == 1 && self.selectedIndex == [tabBar.items indexOfObject:item]) {
       
        NewsViewController *traderIndexVC = (NewsViewController *)((UINavigationController *)self.selectedViewController).viewControllers[0];
        [traderIndexVC beginRefresh];
    }
}

#pragma mark - 处理左右navigationItem点击事件

- (void)showNoticeController
{
     UINavigationController *nav = (UINavigationController *)self.selectedViewController;
    NoticeNewsController  *noticeNewsVC = [[NoticeNewsController alloc] init];
  //  UINavigationController *noticeNav = [[UINavigationController alloc] initWithRootViewController:noticeNewsVC];
    
    noticeNewsVC.hidesBottomBarWhenPushed = YES;
    noticeNewsVC.title = @"实时直播";
    [nav pushViewController:noticeNewsVC animated:YES];
    
}

- (void)showMessageController
{
   UINavigationController *nav = (UINavigationController *)self.selectedViewController;
    MessageListController  *meesageListVC = [[MessageListController alloc] init];
   // UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:meesageListVC];
    
    meesageListVC.hidesBottomBarWhenPushed = YES;
    meesageListVC.title = @"喊单消息";
    [nav pushViewController:meesageListVC animated:YES];


}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = 50;
    tabFrame.origin.y = self.view.frame.size.height - 50;
    self.tabBar.frame = tabFrame;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
