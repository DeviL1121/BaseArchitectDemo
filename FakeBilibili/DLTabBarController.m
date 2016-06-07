//
//  DLTabBarController.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/2.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "DLTabBarController.h"
#import "DLTabBar.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ViewController.h"

@interface DLTabBarController ()

//@property (nonatomic, strong) DLTabBar *customTabBar;

@end
@implementation DLTabBarController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCustomTabBar];
    [self loadChildViewController];
    
}

- (void)loadCustomTabBar {
    DLTabBar *customTabBar = [[DLTabBar alloc] init];
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

- (void)loadChildViewController {
    ViewController *mainVC = [[ViewController alloc] init];
    [self addChildViewController:mainVC withTitle:@"main"];
    
    UINavigationController *navigationVC = [[UINavigationController alloc] init];
    [self addChildViewController:navigationVC withTitle:@"assistant"];
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [navigationVC addChildViewController:secondVC];
    
//    FirstViewController *firstVC = [[FirstViewController alloc] init];
//    [self addChildViewController:firstVC withTitle:@"first"];
    
//    SecondViewController *secondVC = [[SecondViewController alloc] init];
//    [self addChildViewController:secondVC withTitle:@"second"];
    
    
}

- (void)addChildViewController:(UIViewController *)childController withTitle:(NSString *)title {
    childController.title = title;
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    [self addChildViewController:childController];
}


#pragma mark - getter & setter
//- (DLTabBar *)customTabBar {
//    if (_customTabBar == nil) {
//        _customTabBar = [[DLTabBar alloc] init];
//    }
//    return _customTabBar;
//}
@end
