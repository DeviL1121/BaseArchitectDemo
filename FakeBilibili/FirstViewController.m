//
//  FirstViewController.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/2.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "FirstViewController.h"
#import "Define.h"

@interface FirstViewController ()

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation FirstViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundView];
    [self loadLayout];
}

- (void)loadLayout {
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kPadding);
        make.left.mas_equalTo(self.view).mas_offset(kPadding);
        make.bottom.mas_equalTo(self.view).mas_offset(-kPadding);
        make.right.mas_equalTo(self.view).mas_offset(-kPadding);
    }];
}

#pragma mark - gettet & setter
- (UIView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor greenColor];
    }
    return _backgroundView;
}
@end
