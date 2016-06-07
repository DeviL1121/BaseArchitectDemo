//
//  DLPageViewController.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/3.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "DLPageViewController.h"

@interface DLPageViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation DLPageViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    
}

- (void)loadLayout {
    
}


#pragma getter & setter
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor grayColor];
    }
    return _scrollView;
}

@end
