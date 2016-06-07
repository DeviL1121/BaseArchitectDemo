//
//  DLTableCellCollectionItem.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/5.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "DLTableCellCollectionItem.h"
#import "Define.h"

@interface DLTableCellCollectionItem ()

@property (nonatomic, strong) UIView *background;
@end

@implementation DLTableCellCollectionItem

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.background];
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
}

#pragma mark - getter & setter
- (UIView *)background {
    if (_background == nil) {
        _background = [[UIView alloc] init];
        _background.backgroundColor = [UIColor redColor];
    }
    return _background;
}

//- (void)setSelected:(BOOL)selected {
//    self.background.backgroundColor = selected ? [UIColor magentaColor] : [UIColor redColor];
//}

@end
