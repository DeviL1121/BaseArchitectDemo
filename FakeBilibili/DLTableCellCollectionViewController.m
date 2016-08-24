//
//  DLTableCellCollectionViewController.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/5.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "DLTableCellCollectionViewController.h"
#import "Define.h"
#import "DLTableCellCollectionItem.h"

static NSString *kCollectionItenIdentifier = @"TableCellCollectionItem";
@interface DLTableCellCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end
@implementation DLTableCellCollectionViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self loadLayout];
}

- (void)loadLayout {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DLTableCellCollectionItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionItenIdentifier forIndexPath:indexPath];
    return item;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    UIAlertController *AlertVC = [UIAlertController alertControllerWithTitle:@"Selected" message:@"哈哈哈" preferredStyle:UIAlertControllerStyleAlert];
////    __weak typeof(self) weakSelf = self;
//    UIAlertAction *agreeAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        cell.selected = NO;
//    }];
//    [AlertVC addAction:agreeAction];
//    [self presentViewController:AlertVC animated:YES completion:^{
//    }];
    cell.selected = NO;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH - 30) / 2, SCREEN_WIDTH / 2 - 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

#pragma mark - getter & setter
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor cyanColor];
        _collectionView.scrollEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[DLTableCellCollectionItem class] forCellWithReuseIdentifier:kCollectionItenIdentifier];
    }
    return _collectionView;
}


@end
