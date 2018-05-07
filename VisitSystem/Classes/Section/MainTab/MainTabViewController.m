//
//  MainTabViewController.m
//  VisitSystem
//
//  Created by Star on 2018/5/7.
//  Copyright © 2018年 Star. All rights reserved.
//
#import "FontAwesomeKit/FAKFontAwesome.h"

#import "MainTabViewController.h"
#import "HomeViewController.h"
#import "MyViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    NSMutableArray *tabViewControllers = [[NSMutableArray alloc] init];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    homeViewController.tabBarItem.title = @"首页";
    homeViewController.tabBarItem.image = [[FAKFontAwesome homeIconWithSize:24] imageWithSize:CGSizeMake(24, 24)];
    [tabViewControllers addObject:homeViewController];
    
    MyViewController *myViewController = [[MyViewController alloc] init];
    myViewController.tabBarItem.title = @"我的";
    myViewController.tabBarItem.image = [[FAKFontAwesome userIconWithSize:24] imageWithSize:CGSizeMake(24, 24)];
    [tabViewControllers addObject:myViewController];
    
    UIView *tabBarBgColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.bounds.size.width, self.tabBar.bounds.size.height)];
    tabBarBgColorView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:tabBarBgColorView atIndex:0];
    self.tabBar.opaque = YES;
    
    self.viewControllers = tabViewControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
UITabBarController *tabBar = [[UITabBarController alloc] init];
NSMutableArray *array = [[NSMutableArray alloc] init];
for(int i=0; i<10; i++){
    UIViewController *con = [[UIViewController alloc] init];
    con.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0
                                               green:arc4random()%255/255.0
                                                blue:arc4random()%255/255.0
                                               alpha:1];
    con.tabBarItem.title = [NSString stringWithFormat:@"%d视图",i];
    con.tabBarItem.image = [UIImage imageNamed:@"home"];
    con.tabBarItem.selectedImage = [UIImage imageNamed:@"home_fill"];
    [array addObject:con];
}
tabBar.viewControllers = array;
[self presentViewController:tabBar animated:YES completion:nil];
*/

@end
