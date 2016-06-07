//
//  TwoViewController.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/2.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "TwoViewController.h"
#import "Define.h"

@interface TwoViewController ()

@property (nonatomic, strong) UIView *backgrongView;

@end
@implementation TwoViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgrongView];
    [self loadLayout];
    
}

- (void)loadLayout {
    [self.backgrongView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kPadding);
        make.left.mas_equalTo(self.view).mas_offset(kPadding);
        make.bottom.mas_equalTo(self.view).mas_offset(-kPadding);
        make.right.mas_equalTo(self.view).mas_offset(-kPadding);
    }];
}

#pragma mark - getter & setter
- (UIView *)backgrongView {
    if (_backgrongView == nil) {
        _backgrongView = [[UIView alloc] init];
        _backgrongView.backgroundColor = [UIColor yellowColor];
    }
    return _backgrongView;
}
@end
