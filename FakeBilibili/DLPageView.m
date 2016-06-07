//
//  DLPageView.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/2.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "DLPageView.h"
#import "Define.h"
#define kScrollViewWidth SCREEN_WIDTH
#define kScrollViewHeight STATUS_BAR_HEIGHT + 44
#define kButtonWidth SCREEN_WIDTH / 4
#define kButtonHeight 40

@interface DLPageView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIView *indicatorLine;

@end

@implementation DLPageView

#pragma life cycle
- (instancetype)initWithData:(NSMutableArray *)dataArray {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        self.alpha = 0.5;
        self.titleArray = dataArray;
        [self addSubview:self.scrollView];
        [self loadButtonsWithTitleArray:dataArray];
        [self.scrollView addSubview:self.indicatorLine];
        [self loadLayout];
        
    }
    return self;
    
}

- (void)loadButtonsWithTitleArray:(NSMutableArray *)titleArray {
    for (int i = 0; i < titleArray.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * kButtonWidth, STATUS_BAR_HEIGHT, kButtonWidth, kButtonHeight)];
        UIButton *button = [[UIButton alloc] init];
        button.frame = view.bounds;
        button.tag = i;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
            self.selectedButton = button;
        }
        [self.buttonArray addObject:button];
        [view addSubview:button];
        [self.scrollView addSubview:view];
        
    }
    
}

- (void)loadLayout {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
    [self.indicatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kButtonWidth, PAGE_INDICATOR_HEIGHT));
        make.left.mas_equalTo(self.scrollView).mas_offset(self.selectedButton.tag * kButtonWidth);
        make.top.mas_equalTo(self.scrollView).mas_offset(kScrollViewHeight);
    }];
}

#pragma mark - response
- (void)buttonClick:(UIButton *)button {
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    [self changeIndicatorLineToIndex:self.selectedButton.tag];
    if ([self.delegate respondsToSelector:@selector(filpPageToIndex:)]) {
        [self.delegate filpPageToIndex:button.tag];
    }
}

#pragma mark - public method
- (void)indicatorChangeToIndex:(NSInteger)index {
    [self.buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = obj;
        if (idx == index) {
            button.selected = YES;
        }
        else {
            button.selected = NO;
        }
    }];
    [self changeIndicatorLineToIndex:index];
}

#pragma mark - private mehtod
- (void)changeIndicatorLineToIndex:(NSInteger)index {
    [self.indicatorLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scrollView).mas_offset(self.selectedButton.tag * kButtonWidth);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorLine.frame = CGRectMake(index * kButtonWidth, self.indicatorLine.frame.origin.y, kButtonWidth, PAGE_INDICATOR_HEIGHT);
    }];
    [self layoutIfNeeded];
}

#pragma mark - getter & setter
- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor grayColor];
        _scrollView.contentSize = CGSizeMake(kButtonWidth * self.titleArray.count, kScrollViewHeight);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIView *)indicatorLine {
    if (_indicatorLine == nil) {
        _indicatorLine = [[UIView alloc] init];
        _indicatorLine.backgroundColor = [UIColor whiteColor];
    }
    return _indicatorLine;
}


@end
