//
//  DLPageOneTableCell.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/5.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "DLPageOneTableCell.h"
#import "Define.h"
#import "DLTableCellCollectionViewController.h"

#define kCellPading 50

@interface DLPageOneTableCell ()

@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) DLTableCellCollectionViewController *collectionVC;

@end

@implementation DLPageOneTableCell

#pragma mark - life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.background];
        [self.contentView addSubview:self.collectionVC.view];
        [self loadLayout];
    }
    return self;
}

- (void)loadLayout {
    [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
    }];
    [self.collectionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(kCellPading);
        make.left.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-kCellPading);
        make.right.mas_equalTo(self.contentView);
    }];
    
}

#pragma mark - getter & setter
- (UIView *)background {
    if (_background == nil) {
        _background = [[UIView alloc] init];
        _background.backgroundColor = [UIColor darkGrayColor];
    }
    return _background;
}

- (DLTableCellCollectionViewController *)collectionVC {
    if (_collectionVC == nil) {
        _collectionVC = [[DLTableCellCollectionViewController alloc] init];
    }
    return _collectionVC;
}

- (void)setSelected:(BOOL)selected {
//    [self.collectionVC ]
}

@end
