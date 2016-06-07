//
//  ViewController.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/2.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "ViewController.h"
#import "Define.h"
#import "DLPageView.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"

#define kChildViewHeight SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - PAGE_INDICATOR_HEIGHT

@interface ViewController () <DLPageViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) DLPageView *pageView;
@property (nonatomic, strong) NSMutableArray *pageTitle;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) OneViewController *oneVC;
@property (nonatomic, strong) TwoViewController *twoVC;
@property (nonatomic, strong) ThreeViewController *threeVC;
@property (nonatomic, strong) FourViewController *fourVC;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self loadChildViewController];
//    [self displayVC:self.threeVC];
    [self.view addSubview:self.pageView];
    [self.view addSubview:self.scrollView];
    [self loadChildViewController];
    [self loadLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadChildViewController {
    self.oneVC = [[OneViewController alloc] init];
    [self addChildViewController:self.oneVC withIndex:0];
    self.twoVC = [[TwoViewController alloc] init];
    [self addChildViewController:self.twoVC withIndex:1];
    self.threeVC = [[ThreeViewController alloc] init];
    [self addChildViewController:self.threeVC withIndex:2];
    self.fourVC = [[FourViewController alloc] init];
    [self addChildViewController:self.fourVC withIndex:3];
}

- (void)displayVC:(UIViewController *)vc {
    [self.view insertSubview:vc.view atIndex:0];
    [vc didMoveToParentViewController:self];
}

- (void)loadLayout {
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT + PAGE_INDICATOR_HEIGHT));
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pageView.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
}

#pragma mark - DLPageViewDelegate
- (void)filpPageToIndex:(NSInteger)index {
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = index * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger pageIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self.pageView indicatorChangeToIndex:pageIndex];
}

#pragma mark - private method
- (void)addChildViewController:(UIViewController *)childController withIndex:(int)index {
    [self addChildViewController:childController];
    [self.scrollView addSubview:childController.view];
    childController.view.frame = CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, kChildViewHeight);
}

#pragma mark - getter & setter
- (NSMutableArray *)pageTitle {
    if (_pageTitle == nil) {
        _pageTitle = [NSMutableArray arrayWithObjects:@"view1", @"view2", @"view3", @"view4", nil];
    }
    return _pageTitle;
}

- (DLPageView *)pageView {
    if (_pageView == nil) {
        _pageView = [[DLPageView alloc] initWithData:self.pageTitle];
        _pageView.delegate = self;
    }
    return _pageView;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake((self.pageTitle.count) * SCREEN_WIDTH, kChildViewHeight);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

@end
