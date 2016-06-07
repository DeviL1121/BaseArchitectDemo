//
//  OneViewController.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/2.
//  Copyright © 2016年 DeviL. All rights reserved.
//
#import "OneViewController.h"
#import "Define.h"
#import "DLPageOneTableCell.h"

#define kBannerHeight 100
#define kTableViewHeight (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT)

static NSString *kTableViewCellIdentifier = @"PageOneTableCell";

@interface OneViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *tableHeader;
@property (nonatomic, strong) UIView *tableFooter;

@end
@implementation OneViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.tableView];
    [self.tableView.tableHeaderView addSubview:self.tableHeader];
    [self.tableView.tableFooterView addSubview:self.tableFooter];
//        [self.view addSubview:self.collectionView];
    [self loadLayout];
}

- (void)loadLayout {
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kPadding);
        make.left.mas_equalTo(self.view).mas_offset(kPadding);
        make.bottom.mas_equalTo(self.view).mas_offset(-kPadding);
        make.right.mas_equalTo(self.view).mas_offset(-kPadding);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, kTableViewHeight));
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
    }];
    [self.tableHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, kBannerHeight));
    }];
    [self.tableFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).mas_offset(kPadding);
//        make.left.mas_equalTo(self.view).mas_offset(kPadding);
//        make.bottom.mas_equalTo(self.view).mas_offset(-kPadding);
//        make.right.mas_equalTo(self.view).mas_offset(-kPadding);
//    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLPageOneTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier];
    if (!cell) {
        cell = [[DLPageOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableViewCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 380;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - getter & setter
- (UIView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor redColor];
    }
    return _backgroundView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kBannerHeight)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01f)];
        _tableView.allowsMultipleSelection = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[DLPageOneTableCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
    }
    return _tableView;
}

- (UIView *)tableHeader {
    if (_tableHeader == nil) {
        _tableHeader = [[UIView alloc] init];
        _tableHeader.backgroundColor = [UIColor purpleColor];
    }
    return _tableHeader;
}

- (UIView *)tableFooter {
    if (_tableFooter == nil) {
        _tableFooter = [[UIView alloc] init];
        _tableFooter.backgroundColor = [UIColor whiteColor];
    }
    return _tableFooter;
}

//- (UICollectionView *)collectionView {
//    if (_collectionView == nil) {
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//        _collectionView.backgroundColor = [UIColor lightGrayColor];
//    }
//    return _collectionView;
//}

@end
