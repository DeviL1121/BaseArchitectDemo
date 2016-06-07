//
//  DLSecondTableCell.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/6.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "DLSecondTableCell.h"
#import "Define.h"

@interface DLSecondTableCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation DLSecondTableCell

#pragma mark - life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        
        [self loadLayout];
        
    }
    return self;
}

- (void)loadLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.left.mas_equalTo(self.contentView).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
    }];
}

#pragma mark - getter & setter
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _titleLabel;
}

- (void)setWeather:(NSString *)weather {
    _weather = [weather copy];
    self.titleLabel.text = _weather;
}
@end
